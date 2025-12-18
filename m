Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CFD34F49F;
	Thu, 18 Dec 2025 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766075755; cv=none; b=hUHrFOz3JdreEtqeemSonf5V5VDHSgWk3Y/fkJls6QjaGRlY6DfEdGRK0xYbBwD4K4dIjvcHTeyu+UuajG+GfynBi7kFuSOZs0Fh+C6EAYmERwtUrV/8CDR0DXGA4b5qy5kMCKsFqrEa8PDocDahqwSQfLAasAM3CkxuMeGlrwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766075755; c=relaxed/simple;
	bh=S8ZF8ra6hBTTFR2ad5gie3np5D/HNKbZSyoREImCAWk=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=h0Udy8fxM0SBBDm6cpc89JliO22wsqMFBa4kxJGpWD0/NL4xEDSR8YvmzfqTUamj+qJEBvP12wH/jno6Eb0A7ZSWxKxiLqiE8iqqOJiDeL+qQdIiNANArQeXKz/5u33fICiC7/aATlYB5y2wpGrpWAyQZiaiiD2jI/pux0Gk990=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9EzltnV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9EzltnV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CEBC4CEFB;
	Thu, 18 Dec 2025 16:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766075754;
	bh=S8ZF8ra6hBTTFR2ad5gie3np5D/HNKbZSyoREImCAWk=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=d9EzltnVmfiH6jaI/Tz/ammZ0qxFIfP4VtvKO+zB2BL6piy5KwpHU58sLnBdQYkpW
	 ZeUIuGAxmXivHWc716fvjKGm+FzfwGA4kxVIJJB9Et5e7z5PWb0z/GOzIZIsQg2ZML
	 rUbgjPwj3NXyPu3v/VaTVbnHX93hml1TQECaB5NTXTB3R6JF19uQactpYT5NHSCs+T
	 Ymoxjr8B6o27tr+1tQlVnFqVNfVGW71+vKAywsKO9tfXOPb8Gjj99UtPLNWR1jg8ZJ
	 UOqGb3GDk8ieVVpQ/wZMxtaI8Egw8kYCbPkxxkm/M0Blt2V/oK9I5k5v9PcwcGihYJ
	 HyN6vvR8Tz5jg==
Date: Thu, 18 Dec 2025 10:35:51 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Dan Murphy <dmurphy@ti.com>, Mark Brown <broonie@kernel.org>, 
 Kevin Lu <luminlong@139.com>, Takashi Iwai <tiwai@suse.com>, 
 Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Kevin Lu <kevin-lu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Clark Williams <clrkwllms@kernel.org>, devicetree@vger.kernel.org, 
 Shenghao Ding <shenghao-ding@ti.com>, Andrew Davis <afd@ti.com>, 
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 Steven Rostedt <rostedt@goodmis.org>, Baojun Xu <baojun.xu@ti.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
In-Reply-To: <20251218-sound-soc-codecs-tvl320adcx140-v2-8-3c2270c34bac@pengutronix.de>
References: <20251218-sound-soc-codecs-tvl320adcx140-v2-0-3c2270c34bac@pengutronix.de>
 <20251218-sound-soc-codecs-tvl320adcx140-v2-8-3c2270c34bac@pengutronix.de>
Message-Id: <176607575146.242249.14899264595900879843.robh@kernel.org>
Subject: Re: [PATCH v2 08/10] ASoC: dt-bindings: add avdd and iovdd supply


On Thu, 18 Dec 2025 16:04:14 +0100, Sascha Hauer wrote:
> Add bindings for the avdd-supply and iovdd-supply which are named after
> the corresponding pins on the tlv320adcx140 chips.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml:47:15: [error] empty value in block mapping (empty-values)
./Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml:48:16: [error] empty value in block mapping (empty-values)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml: ignoring, error in schema: properties: iovdd-supply
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml: properties:avdd-supply: None is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml: properties:iovdd-supply: None is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml: properties:avdd-supply: None is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml: properties:avdd-supply: None is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml: properties:avdd-supply: None is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml: properties:avdd-supply: None is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml: properties:avdd-supply: None is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml: properties:avdd-supply: None is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml: properties:avdd-supply: None is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml: properties:iovdd-supply: None is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml: properties:iovdd-supply: None is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml: properties:iovdd-supply: None is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml: properties:iovdd-supply: None is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml: properties:iovdd-supply: None is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml: properties:iovdd-supply: None is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml: properties:iovdd-supply: None is not of type 'object', 'boolean'
Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 8, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/doc_validate.py", line 66, in main
    ret |= check_doc(f)
           ~~~~~~~~~^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/doc_validate.py", line 37, in check_doc
    dtsch.check_schema_refs()
    ~~~~~~~~~~~~~~~~~~~~~~~^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 241, in check_schema_refs
    self._check_schema_refs(resolver, self)
    ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 212, in _check_schema_refs
    self._check_schema_refs(resolver, v, parent=k, is_common=is_common,
    ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                            has_constraint=has_constraint)
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 212, in _check_schema_refs
    self._check_schema_refs(resolver, v, parent=k, is_common=is_common,
    ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                            has_constraint=has_constraint)
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 203, in _check_schema_refs
    ref_sch = resolver.lookup(schema['$ref']).contents
              ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 682, in lookup
    retrieved = self._registry.get_or_retrieve(uri)
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 422, in get_or_retrieve
    registry = self.crawl()
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 500, in crawl
    id = resource.id()
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 231, in id
    id = self._specification.id_of(self.contents)
  File "/usr/local/lib/python3.13/dist-packages/referencing/jsonschema.py", line 50, in _dollar_id
    return contents.get("$id")
           ^^^^^^^^^^^^
AttributeError: 'NoneType' object has no attribute 'get'
Documentation/devicetree/bindings/sound/ti,tlv320adcx140.example.dtb: /example-0/i2c/codec@4c: failed to match any schema with compatible: ['ti,tlv320adc5140']

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20251218-sound-soc-codecs-tvl320adcx140-v2-8-3c2270c34bac@pengutronix.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

