Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5D24F93C0;
	Thu, 17 Sep 2026 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664264; cv=none; b=e7q1+hQiFy5H3bx4n/x0xy3hkN5J6Anw3MWMaFwhA0ZkobAlxLBOWH2syX+kZiLh+gw20IhipY4QOwrDHdFWI5iIrKdwfAw9qHP/84JQ4r08OUMWOyxFGBh8xa+6iFNNeSHMmsAmpeEgkTSyrVcAyzmIbR5y0/qp89iqXPI5O14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664264; c=relaxed/simple;
	bh=B3L9UpHoXcugN4pOHbftcrWm91hFHUBy6z+pwFBCiMg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XiAFF4mGUcUf09bpqNI/IfGSQIaPZ2L9RHa9kD2GB8yz0L6mxxIXIDLv7+mzt7buHbyej1F+o752yB40sYOVW+ct88rsuDdjXjTQ5Hf3+yUJm+z3UQlA7b0QOfw6ZtQaHZjE0ZNPUE44ijPjVzOQzdYOtK4oVP52iyuUAcMbFuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCbvTMIb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCbvTMIb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390201F000FF;
	Thu, 17 Sep 2026 16:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789664263;
	bh=WTHGYau84w7vw3YMl4OjEoYJpFQd/6G7nW3gRxw5Xho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NCbvTMIbR1zxj6v7W2WmNt6fFAyBliACrLBGksoRCO5auTTSpfpBc6Tr3CQuHfx75
	 apyKlBmxT4K+3yOw9rfFVfdmrFy+3wWnaANn2m02kHuW9VgW4D0sC4QOEaQJ9QHO47
	 TbeJ9Kblu6+wZjTq8POU2wuwJvt1vA3CDbHi8P/ORhb1sfKpzBO0ikZKdOzot4Ceh4
	 LxP3JZKSovqPEHyzDqeST0cPI532z5CYIvTvQCdtMA41a80KHEPlq+iOdEGEou2Rl8
	 v91ZRyuxznUJI93NsZ+dCGXLnHGJqb2Wc8UVNExBo3G24xDPbytF/yrL9bGHuJSBtQ
	 D2LFrKhCb3NCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/5] riscv_cbqri: resctrl: Add cache allocation via
 capacity block mask
Reply-To: sashiko-reviews@lists.linux.dev
To: "Drew Fustini" <fustini@kernel.org>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260917-dfustini-atl-sc-cbqri-dt-v8-2-7964e8d73fe8@kernel.org>
References: <20260917-dfustini-atl-sc-cbqri-dt-v8-0-7964e8d73fe8@kernel.org>
 <20260917-dfustini-atl-sc-cbqri-dt-v8-2-7964e8d73fe8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:57:42 +0000
Message-Id: <20260917165743.390201F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] cbqri: late-registered capacity controllers bypass capability ag=
reement check
--

commit d3ff1ae1d79d6e8e4041b4efbc3516187f2222a6
Author: Drew Fustini <fustini@kernel.org>

riscv_cbqri: resctrl: Add cache allocation via capacity block mask

This commit wires up CBQRI capacity controllers into resctrl for L2 and
L3 resources. It manages control domains during CPU hotplug and requires
all controllers at the same cache level to report identical capabilities.

> diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_resc=
trl.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/resctrl/cbqri_resctrl.c

[ ... ]

> +static int cbqri_attach_cpu_to_all_ctrls(unsigned int cpu)
> +{
> +	static const u32 levels[] =3D { 2, 3 };
> +	struct cbqri_controller *ctrl, *c;
> +	struct cbqri_resctrl_res *hw_res;
> +	struct rdt_ctrl_domain *d;

[ ... ]

> +		d =3D cbqri_find_ctrl_domain(&hw_res->resctrl_res.ctrl_domains,
> +					   ci->id);
> +		if (d) {
> +			cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
> +			continue;
> +		}
> +
> +		d =3D cbqri_create_ctrl_domain(ctrl, &hw_res->resctrl_res, cpu,
> +					     ci->id);

[Severity: Medium]
Does this bypass the capability agreement check for dynamically registered
controllers?

If a CBQRI capacity controller is registered late (for instance, via a DT
overlay) and its CPU is subsequently onlined,
cbqri_attach_cpu_to_all_ctrls() will discover the controller backing the
new CPU and create a domain for it.

However, I don't see a call to cbqri_cc_caps_agree(hw_res->ctrl, ctrl)
before creation to verify that the late controller's capabilities match.
If the new controller has capabilities (like block mask size or RCID count)
that differ from the boot-time selected controller, will this group
mismatched controllers into the same resctrl resource?

Could this cause capacity configuration operations to fail gracefully with
-EIO when hardware limits are exceeded, or otherwise abort CPU hotplug?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-dfustini-a=
tl-sc-cbqri-dt-v8-0-7964e8d73fe8@kernel.org?part=3D2
