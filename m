Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B352030A;
	Fri, 16 Oct 2026 00:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109187; cv=none; b=HrstzWFfYZSR4400t3cj+LA65k0RT4wiOU79CaURfBhoNAQvS2+B/5EjFM3DwFrFT4bMV2m0qszFJrSSx/qEU2hSBfW1m75WnTdrJJVkRAocblzzv0KGKZMTWAwGLFEUY4/FqSiX5kQtMyeunZfK+tNW4ZdNli9qr6aPNLAtneM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109187; c=relaxed/simple;
	bh=JQNlIBOrQQ4CZzFwrfBRyxU2RHdddOs451H/qbf3jVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qf2Xye0uyfE1BTGBcS4jQXx1pqpbbb8XdC1xqvlPKwssIX6s9tkmBcU2KreeY73qeuwvtKoxF1/R4Ztx8RpYnUQlBrYwdgkhrLqJk9mteVbP3aOQB36PBuDTGFjIqHtfYtOrQ3aIriIU8iAHvmcS7jOeX0TXAiEAncTc1W7qIR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOHnLwpw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOHnLwpw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB1C1F000C4;
	Fri, 16 Oct 2026 00:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792109186;
	bh=lj0QXNDYWzykhho+9TgSGkXQQEpotIYDIIMXMua7eT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oOHnLwpwzXtkpHlf/6U6iF7vR87WzvWbEDkOSs+3dp8FKUwEDtOEWfd+6JMd2ssjz
	 GksAiaUpsIWqUo0dFVk155pkKrt/uQGX1NYw1QEdERp+A1Nt6fjyyEr0VjxDe3MTLn
	 y3tG+1pIiDhw0uPafqBUYvc9Ob3kIiwceYOBmf8l7m9JtxTkieKn+UDxCnUf+6eCLS
	 OeTrKt80VAXQzJyVsPTmXXwbritv3DMzHM+pKHlhVzZH8TactA4tSM7tc2hImMGgUV
	 ren66sBe8znD4ykW994KGmIo/iQIXn+69G6S9pkjIAYVzlA6PWgkL1vtq3LBsyYzxv
	 dfLtdDCrcOvRw==
Date: Thu, 15 Oct 2026 17:06:24 -0700
From: Drew Fustini <fustini@kernel.org>
To: Sunil V L <sunilvl@oss.qualcomm.com>
Cc: Adrien Ricciardi <aricciardi@baylibre.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>,
	Atish Patra <atish.patra@linux.dev>,
	Babu Moger <babu.moger@amd.com>, Ben Horgan <ben.horgan@arm.com>,
	Borislav Petkov <bp@alien8.de>, Chen Pei <cp0613@linux.alibaba.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Martin <Dave.Martin@arm.com>, Fenghua Yu <fenghuay@nvidia.com>,
	Gong Shuai <gong.shuai@sanechips.com.cn>,
	Gong Shuai <gsh517@gmail.com>, guo.wenjia23@zte.com.cn,
	James Morse <james.morse@arm.com>,
	Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, liu.qingtao2@zte.com.cn,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Peter Newman <peternewman@google.com>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tony Luck <tony.luck@intel.com>,
	Vasudevan Srinivasan <vasu@rivosinc.com>,
	Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li <liwei1518@gmail.com>,
	yunhui cui <cuiyunhui@bytedance.com>,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	x86@kernel.org, devicetree@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 1/5] riscv_cbqri: Add capacity controller probe and
 allocation device ops
Message-ID: <atFqgJc4Vg2XPGl0@thelio>
References: <20261003-dfustini-atl-sc-cbqri-dt-v9-0-52fd8be98dcf@kernel.org>
 <20261003-dfustini-atl-sc-cbqri-dt-v9-1-52fd8be98dcf@kernel.org>
 <CAB19ukHJ-TxXu+vMGGNqHz2sJj35Cg0X1RbcdfXzwDYpci1jQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB19ukHJ-TxXu+vMGGNqHz2sJj35Cg0X1RbcdfXzwDYpci1jQw@mail.gmail.com>

On Mon, Oct 12, 2026 at 09:42:59PM +0530, Sunil V L wrote:
> Hi Drew!

Hi Sunil, thanks for reviewing!

> On Sat, Oct 3, 2026 at 12:45 PM Drew Fustini <fustini@kernel.org> wrote:
> >
> > Add support for the RISC-V CBQRI capacity controller. A platform driver
> > passes a cbqri_controller_info descriptor together with the cache level
> > to riscv_cbqri_register_cc_dt(), which probes the controller and adds it
> > to the controller list.
> >
> > Assisted-by: LLM
> > Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> >  MAINTAINERS                      |   3 +
> >  drivers/resctrl/Kconfig          |   9 +
> >  drivers/resctrl/Makefile         |   3 +
> >  drivers/resctrl/cbqri_devices.c  | 574 +++++++++++++++++++++++++++++++++++++++
> >  drivers/resctrl/cbqri_internal.h | 122 +++++++++
> >  include/linux/riscv_cbqri.h      |  45 +++
> >  6 files changed, 756 insertions(+)
[..]
> > diff --git a/drivers/resctrl/cbqri_devices.c b/drivers/resctrl/cbqri_devices.c
> > new file mode 100644
> > index 000000000000..87d4ecf8f141
> > --- /dev/null
> > +++ b/drivers/resctrl/cbqri_devices.c
[..]
> > +static int cbqri_probe_controller(struct cbqri_controller *ctrl)
> > +{
[..]
> > +
> > +       if (!request_mem_region(ctrl->addr, ctrl->size, "cbqri_controller")) {
> > +               pr_err("request_mem_region failed for %pa\n", &ctrl->addr);
> > +               return -EBUSY;
> > +       }
> > +
> Apologies for jumping on this late. But why not simply use
> devm_platform_ioremap_resource() ?

This is an artifact of my fuller RFC series which implemented RQSC as
well. For ACPI, it registers controllers directly from the RQSC table
without a platform device.

But you make a good point and this is what MPAM does as well. I will
switch to devm_platform_get_and_ioremap_resource() and add a base field
to cbqri_controller_info.

> > +/**
> > + * riscv_cbqri_register_cc_dt() - register a DT-described capacity controller
> > + * @info:        registration descriptor. info->cache_id is used as the
> > + *               resctrl domain id. info->type must be CAPACITY.
> > + * @cache_level: cache level (2 or 3) the controller backs, mapped to the
> > + *               resctrl L2/L3 resource by the resctrl glue.
> > + *
> > + * The cache level and id (info->cache_id) are supplied directly by the
> > + * caller, which resolves them from cacheinfo. Domain membership is resolved
> > + * per CPU at hotplug, so no cpu mask is stored. There is no firmware table
> > + * to resolve any of this from.
> > + *
> > + * Return: 0 on success, -EEXIST when a controller for the same cache level
> > + * and id is already registered, or another negative errno on failure.
> > + */
> > +int riscv_cbqri_register_cc_dt(const struct cbqri_controller_info *info,
> > +                              u32 cache_level)
> >
> What is DT specific code in this function? IMO, it is better to gather
> all information in the main
> driver itself into a generic "info" structure. That way, all ACPI vs
> DT differences will be handled in
> one place and everything further will be generic.

There is nothing that is DT specific beyond needing to pass the cache
level whereas ACPI can determine it from PPTT.

But I think it would make sense to be more generic. I will move
cache_level into cbqri_controller_info and drop the _dt suffix.

[..]
> > +       /*
> > +        * SRMCFG encodes RCID in 12 bits. Reject an out-of-range count rather
> > +        * than silently truncating in every FIELD_PREP(SRMCFG_RCID_MASK, closid)
> > +        * on the schedule-in fast path.
> > +        */
> > +       if (ctrl->rcid_count > FIELD_MAX(SRMCFG_RCID_MASK) + 1) {
> > +               pr_warn("CC at %pa has RCID count %u beyond the 12-bit SRMCFG field, skipping\n",
> > +                       &ctrl->addr, ctrl->rcid_count);
> > +               cbqri_controller_destroy(ctrl);
> >
> Any reason to have explicit cleanups ?

No. I will move the info->rcid_count check before allocation and use
__free() for the controller.

[..]
> > diff --git a/drivers/resctrl/cbqri_internal.h b/drivers/resctrl/cbqri_internal.h
[..]
> > +extern struct list_head cbqri_controllers;
> > +extern struct mutex cbqri_controllers_lock;
> > +
> >
> Can these be made static in cbqri_devices.c and provide API for cbqri_resctrl.c?

Yes, the only use outside of cbqri_devices.c is
cbqri_resctrl_pick_caches(). I will make both static and add a helper
that returns the registered controllers.

Thanks,
Drew
