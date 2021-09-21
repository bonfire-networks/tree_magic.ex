use std::path::Path;
use rustler::{Binary, Encoder, Env, Error, NifResult, Term};
use petgraph::Incoming;

mod atoms {
    rustler::atoms! {
        ok,
        error,
        enoent,
    }
}

rustler::init!(
    "Elixir.TreeMagic",
    [from_u8, from_filepath, is_alias, match_u8, match_filepath]
);

#[rustler::nif]
fn from_u8(bytes: Binary) -> String {
    tree_magic::from_u8(bytes.as_slice())
}

#[rustler::nif]
fn from_filepath<'a>(env: Env<'a>, path_str: &str) -> NifResult<Term<'a>> {
    let path = Path::new(path_str);
    let node = tree_magic::TYPE.graph.externals(Incoming).next();

    match node {
        Some(node) => {
            let term = match tree_magic::from_filepath_node(node, path) {
                Some(mime) => (atoms::ok(), mime).encode(env),
                None => (atoms::error(), atoms::enoent()).encode(env)
            };

            Ok(term)
        },
        // this shouldn't happen
        None => Err(Error::RaiseAtom("mime_not_loaded")),
    }
}

#[rustler::nif]
fn is_alias(mime1: &str, mime2: &str) -> bool {
    tree_magic::is_alias(mime1.to_string(), mime2.to_string())
}

#[rustler::nif]
fn match_u8(mimetype: &str, bytes: Binary) -> bool {
    tree_magic::match_u8(mimetype, bytes.as_slice())
}

#[rustler::nif]
fn match_filepath(mimetype: &str, path_str: &str) -> bool {
    let path = Path::new(path_str);

    tree_magic::match_filepath(mimetype, path)
}
