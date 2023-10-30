<form method="post" id="form_doc" name="form_doc" onsubmit="return submit_form_doc();">

    <table class="table table-sm table-bordered">

        <tr>
            <td>

                <input type="file" id="doc_attach" class="form-control" name="doc_attach" accept=".pdf,.jpg,.jpeg,.png,.docx,.txt,.doc">

            </td>
            <td>
                <input type="hidden" name="u_id" value="<cfoutput>#u_id#</cfoutput>">
                <input type="hidden" name="attach_type_id" value="<cfoutput>#attach_type_id#</cfoutput>">
                <input type="hidden" name="dir_go" value="<cfoutput>#SESSION.BO_ROOT#/admin/trainers</cfoutput>">
				<input type="submit" class="btn btn-info btn-sm" id="doc_upload_submit" value="upload">
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="progress">
                    <div class="progress-bar progress-bar-animated bg-info" role="progressbar" id="progress_doc" style="width: 0%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
            </td>
        </tr>
    </table>

 </form>