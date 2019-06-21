const errorsFormatter = err => {
  errorsObj = err.errors;
  errorFields = Object.keys(errorsObj);
  console.log(err);
  errors = errorFields.map(error => {
    const { message, kind, path, value } = errorsObj[error];
    return {
      message,
      validationType: kind,
      fieldName: path,
      value
    };
  });
  return errors;
};

module.exports = errorsFormatter;
