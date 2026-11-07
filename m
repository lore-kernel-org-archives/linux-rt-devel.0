Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794043229;
	b=Nau4T6JCHXLqTGopKA+0S/wFDz2vy7XhTZR5jTADmu+Gplkgy6jddIo+hfyIPqXfcbNK
	 j430gIsGqZe4b3ICVfEWGZS/YPnCuoj/jskswL0ESM6imE7zyNnCBZfqVNvxRFOzApcKL
	 rCCIx2vM2HErPQYV1zbbyFcjwfS4XKMkFf+R/orV4A4uoV/o/sglhrelOst5O4mGYdxGu
	 c4SAZuU/3Tt8wUudNGJeQfjbap1XNcG7ytpDt3MB0eMEH0SHHqpqEOB8Y1buuR5KWcV71
	 rObOcWmhXOmuXXHa//cWCdH7yOW5SrF55xyH+rvZJpnrbdbOEDJkKw01QZq6xTDuPOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794043229;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fH9ZInNpZ+Ow6HAJ32cdUs+0EKHjb4TvJ+Ry64dX10Q=;
	b=iftN3G1x7oKSquh+TOWZFFTqJSQQ0ciL4OX8MU2CvWTf7QKiEkPlEscGaujqNgtrFyt1
	 8iqGu3vNmSQUWEIfnSEWnDk2PnLBUOhmTSYTMlrqktM6kRwvLL4jslvQVS2hBSJFmOu63
	 SU4gJmKKi36t4mERFu9xxPGfywZwvUe3YsKi+NE48NebeQmT9mRBi9bAAXo6rREOy3s9G
	 /TlC6rqeqtR8J7/WgNempjaDAPVBWysAcRdAFZbv0NYar732DEAgWFWBKiqzwHQ5vbiNz
	 Ow1W0Y8ZEDSd0KLFp6bMzWNF+DqTZuA2fNx1/B1Iv+s2V7mV2XfbQi4hS+y1auLm5WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5GoGyn3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DBD606A331;
	Sat,  7 Nov 2026 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5GoGyn3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CFF1F008A1;
	Sat,  7 Nov 2026 09:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794043229;
	bh=fH9ZInNpZ+Ow6HAJ32cdUs+0EKHjb4TvJ+Ry64dX10Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F5GoGyn3lMJu3cvNGtf5C3shHt9FK1KfyDIqtU3wPBLcZTZ/+UIkOZZsCJbSSajuy
	 12aPokzfSYEvZV3pnGvAGaTgovNT+j3QV07Ookc2EW/arDBNakzfyF4D73UMgBI62v
	 5d4MsNYgCDFiWPt3N2H280N8JAFFhVH+DX774G3OwL26jSqzsdpPATUC4BGvfDWJwX
	 AgMU2VyCm1P6TDFqSToTOj+NPyCUiBkrLQl5eteCXnStcONHdXBrnYTufvGj+CW+mv
	 3X40eRlyEjEEvlABwg9t8Y2t1+QJz8/lWBDhtroKGl8GyT5JXJCZsED2n2xAF2kkQR
	 eF1KQB1JYP8VQ==
Message-ID: <sashiko-outbox-202761@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 06/10] kconfig-checker: Split schema to support
 component reuse
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ahmed S. Darwish" <darwi@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Ingo Molnar" <mingo@redhat.com>, "Nathan
 Chancellor" <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>
Cc: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Frederic
 Weisbecker" <frederic@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jonathan
 Corbet" <corbet@lwn.net>, "John Ogness" <john.ogness@linutronix.de>, "Derek
 Barbosa" <debarbos@redhat.com>, =?utf-8?b?WmJpZ25pZXcgSsSZZHJ6ZWpld3Nr?=
 =?utf-8?b?aS1Tem1law==?= <zbyszek@amutable.com>, "Daan De Meyer" <daan.j.demeyer@gmail.com>, "Luca
 Boccassi" <luca.boccassi@gmail.com>, linux-rt-devel@lists.linux.dev, debian-kernel@lists.debian.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261106091922.7560-7-darwi@linutronix.de>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <20261106091922.7560-7-darwi@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 09:20:28 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Low] kconfig-checker: stale schema path in
  Documentation/tools/kconfig_checker.rst
- [Low] kconfig-checker: missing type: ignore on Draft7Validator import
- [Low] kconfig-checker: unused Schema.as_dict() method left behind in
  check.py
--

commit e95d8c61bd1b396a43ce4115372f7685c287a202
Author: Ahmed S. Darwish <darwi@linutronix.de>

kconfig-checker: Split schema to support component reuse

This commit moves the common rule schema into schemas/base.yml, adds
schemas/rules.yml for complete rule files, and updates check.py to resolve
local file:// schema references using Draft7Validator.

> diff --git a/tools/kconfig-checker/check.py b/tools/kconfig-checker/check=
.py
> index ef49c28b9dab6..4f79ec487da79 100755
> --- a/tools/kconfig-checker/check.py
> +++ b/tools/kconfig-checker/check.py
> @@ -80,6 +80,8 @@ except ModuleNotFoundError as e:
>  # Actual script:
>  #
> =20
> +from jsonschema import Draft7Validator

[Severity: Low]
Does this import need a "# type: ignore" comment to match the earlier
"import jsonschema" statement?  Without it, running "mypy --strict
--no-warn-return-any check.py" as documented in the file header fails with
a missing-stubs error (or fails on the earlier "# type: ignore" when
types-jsonschema is installed).

[ ... ]

>      def as_dict(self) -> YamlDict:
>          return self.schema
> @@ -273,7 +308,7 @@ class RulesFile:
> =20
>      def __init__(self, yaml_f: Path, schema: Schema):
>          self.yaml =3D Helpers.load_yaml(yaml_f)
> -        Helpers.validate_yaml(self.yaml, schema.as_dict(), yaml_f.name)
> +        Helpers.validate_yaml(self.yaml, schema.validator, yaml_f.name)

[Severity: Low]
This isn't a bug, but now that RulesFile.__init__() and
Helpers.validate_yaml() take schema.validator instead of schema.as_dict(),
Schema.as_dict() has no remaining callers in this patch or later in the
series and could be removed.

[ ... ]

> @@ -533,6 +568,7 @@ def parse_args(rules: list[str]) -> argparse.Namespac=
e:
>  def main() -> None:
>      base_dir =3D Path(__file__).resolve().parent
>      rules_dir =3D base_dir / 'rules'
> +    schema_dir =3D base_dir / 'schemas'
> =20
>      rules_l =3D sorted(path.stem for path in rules_dir.glob('*.yml'))
>      args =3D parse_args(rules_l)
> @@ -544,7 +580,7 @@ def main() -> None:
>      kconfig_f =3D args.config.resolve()
>      kconfig =3D KernelConfig(kconfig_f)
> =20
> -    schema_f =3D base_dir / 'schema.yml'
> +    schema_f =3D schema_dir / 'rules.yml'

[Severity: Low]
Should Documentation/tools/kconfig_checker.rst also be updated here now
that tools/kconfig-checker/schema.yml has moved to
tools/kconfig-checker/schemas/base.yml and
tools/kconfig-checker/schemas/rules.yml?  Later commit "Documentation:
Describe kconfig-checker overlays" updates that section to reference
tools/kconfig-checker/base.yml and tools/kconfig-checker/rules.yml,
omitting the schemas/ directory component.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106091922.7560=
-1-darwi@linutronix.de?part=3D6
