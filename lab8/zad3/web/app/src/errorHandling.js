const errorHandler = (errorMsg) => {
  return (error) => console.error(`${errorMsg}:\n`, error);
};

const checkFields = (obj, fields) => {
  let errors = {};

  for (const field of fields) {
    if (!(field in obj)) {
      errors[field] = "not provided";
    }
  }

  for (const _ in errors) {
    return [true, errors];
  }

  return [false, {}];
};

module.exports = { errorHandler, checkFields };
