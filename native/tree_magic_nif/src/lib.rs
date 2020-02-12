use std::path::Path;
use rustler::{Binary, Encoder, Env, Error, Term};
use petgraph::Incoming;

mod atoms {
    rustler::rustler_atoms! {
        atom ok;
        atom error;
        atom enoent;
    }
}

rustler::rustler_export_nifs! {
    "Elixir.TreeMagic",
    [
        ("from_u8", 1, from_u8),
        ("from_filepath", 1, from_filepath),
        ("is_alias", 2, is_alias),
        ("match_u8", 2, match_u8),
        ("match_filepath", 2, match_filepath),
    ],
    None
}

fn from_u8<'a>(env: Env<'a>, args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    let bytes: Binary = args[0].decode()?;

    Ok(tree_magic::from_u8(bytes.as_slice()).encode(env))
}

fn from_filepath<'a>(env: Env<'a>, args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    let path_str: &str = args[0].decode()?;
    let path = Path::new(path_str);
    let node = tree_magic::TYPE.graph.externals(Incoming).next();

    match node {
        Some(node) => {
            let term = match tree_magic::from_filepath_node(node, path) {
                Some(mime) => (atoms::ok(), mime).encode(env),
                None => (atoms::error(), atoms::enoent()).encode(env),
            };

            Ok(term)
        },
        // this shouldn't happen
        None => Err(Error::RaiseAtom("mime_not_loaded")),
    }
}

fn is_alias<'a>(env: Env<'a>, args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    let mime1: &str = args[0].decode()?;
    let mime2: &str = args[0].decode()?;

    Ok(tree_magic::is_alias(mime1.to_string(), mime2.to_string()).encode(env))
}

fn match_u8<'a>(env: Env<'a>, args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    let mimetype: &str = args[0].decode()?;
    let bytes: Binary = args[1].decode()?;

    Ok(tree_magic::match_u8(mimetype, bytes.as_slice()).encode(env))
}

fn match_filepath<'a>(env: Env<'a>, args: &[Term<'a>]) -> Result<Term<'a>, Error> {
    let mimetype: &str = args[0].decode()?;
    let path_str: &str = args[1].decode()?;
    let path = Path::new(path_str);

    Ok(tree_magic::match_filepath(mimetype, path).encode(env))
}
