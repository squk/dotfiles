autocmd InsertLeave * :lua require('google.comments').update_signs()
autocmd InsertLeave * :GoogleCommentsFetchComments
