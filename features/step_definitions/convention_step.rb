Allora /^dovrei essere nella pagina di dettagli di una convention$/ do
  c=Convention.first
  assert_equal convention_path(c), URI.parse(current_url).path
end