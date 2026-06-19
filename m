Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4CF33D6D6;
	Fri, 19 Jun 2026 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781894415; cv=none; b=YrK6CXUk1quP4tpwfYb6jr8EZkjn5ijn5RQUR4HnGxhFOiJiz2l0EvrhHZh6tr+CuKsjZyn6M9NcimXgN3Q97g6ldVeeTLbEUw9Tz6KtaKBcZaYz7ITTFEFtdw4KcJqMm/XtjziOX6H+6KnbZm765eEYnu8C8OgYsJn3+aCvDlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781894415; c=relaxed/simple;
	bh=kideF2nvxhPlOqP2XYPRtyLTNGh8Cj8iN9qgDGrAZQU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TS8c9zK4seOb/sjkOps07dzuySDfAF8KWmDjhQmQdiQ0euR+i1wc1mbmGWZD4QKsdCN7sDhzgSbz2DrSYEQSWV8sgA6ZBj8pwqGWzwnBAbY5EBOCMU79c11q8vmjlPQqQ8fjuGQ44mdbG8s9gkW0spv04eiKSr3cedQehRR+tXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktCAIibq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktCAIibq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E439C1F000E9;
	Fri, 19 Jun 2026 18:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781894413;
	bh=+QCD/m3yUimYF8FQ9uS7uW4iGZymEiDymzLsvEYzV0M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ktCAIibqRt8h/l64GMin5kmHOP0477MriB2gsn7kJlDkkKMZARKjoBBKDh+WwrHJo
	 buqzk+sHPw0NcMdbnCi/jlVC6gn0oY0zL2eSQlTTFonzznGi1rXkN54XKtVcvPEEYY
	 +gyuLcCV7CwA0IN4sDEZYde6viczfLYVK3y4VqGjGeIk+o6NxOqTBc4A3mtyTq4zcR
	 8musGvGvd5LUlfbJ2fxUb4Q8+cPAA8X+63ebWU1sJy+FLBKS+iAhL2Bqd5cHBDRU+I
	 zzHAeUFdXE3MWZwOSZHUwg56D9g1VRnHtXs0UXqlwsQVWQd2mm3AfqT2U1+3N0frdw
	 NxsYGixrM5Iog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] riscv_cbqri: Add capacity controller probe and
 allocation device ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Drew Fustini" <fustini@kernel.org>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260619-dfustini-atl-sc-cbqri-dt-v1-4-e79a7723fab0@kernel.org>
References: <20260619-dfustini-atl-sc-cbqri-dt-v1-0-e79a7723fab0@kernel.org>
 <20260619-dfustini-atl-sc-cbqri-dt-v1-4-e79a7723fab0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 18:40:12 +0000
Message-Id: <20260619184012.E439C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unsynchronized mutation of the global `cbqri_controllers` list dur=
ing controller registration.
--

commit 9ebbab9c601133916a2f8c8128683147a9f601b3
Author: Drew Fustini <fustini@kernel.org>

riscv_cbqri: Add capacity controller probe and allocation device ops

This commit adds support for the RISC-V CBQRI capacity controller. It
provides a platform driver interface to probe the controller and register it
to a global controller list.

> diff --git a/drivers/resctrl/cbqri_devices.c b/drivers/resctrl/cbqri_devi=
ces.c
> new file mode 100644
> index 0000000000000..cc4ec3f25ac18
> --- /dev/null
> +++ b/drivers/resctrl/cbqri_devices.c

[ ... ]

> +int riscv_cbqri_register_cc_dt(const struct cbqri_controller_info *info,
> +			       u32 cache_level, const struct cpumask *cpu_mask)
> +{

[ ... ]

> +	if (ctrl->alloc_capable && !ctrl->rcid_count) {
> +		pr_warn("CC at %pa is alloc-capable but has no RCID count, skipping\n",
> +			&ctrl->addr);
> +		cbqri_controller_destroy(ctrl);
> +		return -EINVAL;
> +	}
> +
> +	list_add_tail(&ctrl->list, &cbqri_controllers);

[Severity: High]
Does this list insertion need synchronization?

If the kernel is configured to probe platform devices asynchronously (e.g.,
via the driver_async_probe kernel parameter) and there are multiple CBQRI
capacity controller nodes in the device tree, multiple probes could execute
riscv_cbqri_register_cc_dt() concurrently.

This lockless modification to the global cbqri_controllers list could
corrupt the list's next and prev pointers and result in a kernel panic.

> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619-dfustini-a=
tl-sc-cbqri-dt-v1-0-e79a7723fab0@kernel.org?part=3D4
