Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2933D1ABD;
	Sat, 17 Oct 2026 20:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792270615; cv=none; b=lI6zdgliTPwKdZ8JILQ8pvt3G57i7SM1yjW1mTBQ2vlMm3n8PBZx3LOLehtXP/HHkqI8kKtqhsTdpRJWWRqO4B/ZACgapOvk+xAFV743pMI5E7IPN9ieNfujosDgKqsusa28YGauaEFJsZ3ZtEN0HIhEb4KUU8YGwOqtElg1Nxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792270615; c=relaxed/simple;
	bh=aNBNRODfl+LBphR93nXPTS1UcwhBxEF/nlaa1RPjIH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZvXr3BGanbNw1FCM3iPRi3UKRk2XV4bDQpBQh9VLx3u6gnQeuEwQ5QtBmicENFJuY1bw+VfBMc/ZshrOmnH/O4oocUGjr4trw1s70rV0h2+3dbLsZrnmiC1roKIjw1gxNEmbEW3w2LH6kAyoE9XKGzyOjQbQCsgdwJkeDkcAss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocoofUb5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocoofUb5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE3C1F000C4;
	Sat, 17 Oct 2026 20:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792270613;
	bh=ICaHlESv3/ZEgb0CL6c9OpvIzwqhaxILgNv0hKoeWb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ocoofUb5j8zOL9hJxSUpD9COIXYE+Qb98ZjzeRsCrYCd2mgQCqyg5Y9Kfmp48uxj/
	 C6vcahxYvFOvszO4UHHTNQvghBy6IQZqB+J16ZtYEKbEDEFWPuJH0xXNniJJ8K0m0u
	 x62noQj5k+QgnRLu1jJJ+8p4WTl2aOM8fNd+Fv8Xqoth1mW47YurD51peFurGGYUMb
	 jDRCCbXsBvqJ0ZOA1xJEuZvq3RwsSRvvitD0ppxwT8yzEuCyosnk0hxjmTEgXBYqPY
	 wFMNSwaLXbD9nzQRvYPgdwwxkUXWWO/bO0cCFODqPnNZNgi/bY1ENy6Fs5KedcMjoU
	 bWwQlAV/qYIUg==
Date: Sat, 17 Oct 2026 13:56:51 -0700
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
Subject: Re: [PATCH v9 2/5] riscv_cbqri: resctrl: Add cache allocation via
 capacity block mask
Message-ID: <atPhE6rF0Uz93qF2@thelio>
References: <20261003-dfustini-atl-sc-cbqri-dt-v9-0-52fd8be98dcf@kernel.org>
 <20261003-dfustini-atl-sc-cbqri-dt-v9-2-52fd8be98dcf@kernel.org>
 <CAB19ukEkAOMnPpi2jVFz68GZ_7cwYmNtrBkxnfEJtFcPb7PJ5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB19ukEkAOMnPpi2jVFz68GZ_7cwYmNtrBkxnfEJtFcPb7PJ5Q@mail.gmail.com>

On Mon, Oct 12, 2026 at 10:23:57PM +0530, Sunil V L wrote:
> On Sat, Oct 3, 2026 at 12:45 PM Drew Fustini <fustini@kernel.org> wrote:
> >
> > Wire CBQRI capacity controllers into resctrl as RDT_RESOURCE_L2 and
> > RDT_RESOURCE_L3 schemata.
> >
> > resctrl exposes a single capacity mask per resource, so when more than
> > one capacity controller backs a cache level they must report the same
> > number of capacity blocks. The same holds for the other capabilities
> > resctrl exposes once per resource. A level whose controllers disagree
> > is left unexposed. Other levels are unaffected.
> >
> > The set of controllers backing each level is fixed when resctrl is set
> > up at late_initcall. Control domains are created in the cpuhp online
> > callback and keyed on the onlining CPU's cache id from cacheinfo, so a
> > CPU that is offline at probe time still joins its domain once it comes
> > online, provided a controller for its cache is in that set. A CPU whose
> > cache has no controller is left out of that level and a warning is
> > logged once. A domain is published on the ctrl_domains RCU list only
> > after it is fully initialized and brought online, and removed from the
> > list before it is taken offline, following the documented safe
> > traversal rules.
> >
> > Assisted-by: LLM
> > Tested-by: Chen Pei <cp0613@linux.alibaba.com>
> > Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> >  MAINTAINERS                      |   2 +
> >  arch/riscv/include/asm/resctrl.h | 147 +++++++
> >  drivers/resctrl/Kconfig          |   4 +
> >  drivers/resctrl/Makefile         |   1 +
> >  drivers/resctrl/cbqri_resctrl.c  | 831 +++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 985 insertions(+)
[..]
> > diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_resctrl.c
> > new file mode 100644
> > index 000000000000..f10a24761b25
> > --- /dev/null
> > +++ b/drivers/resctrl/cbqri_resctrl.c
[..]
> > +static int cbqri_resctrl_setup(void)
> > +{
> > +       int rid;
> > +       int err;
> > +
> > +       for (rid = 0; rid < RDT_NUM_RESOURCES; rid++)
> > +               cbqri_resctrl_resources[rid].resctrl_res.rid = rid;
> > +
> Why can't cbqri_resctrl_control_init directly use
> cbqri_resctrl_resources? I feel this initialization is redundant.

This is similar to what x86 and arm mpam also do since it is important
before any resctrl code is called. for_each_rdt_resource() will get
stuck in a loop if the rid values are not initialized. In contrast,
cbqri_resctrl_control_init() only handles the resources for which
cbqri_resctrl_pick_caches() found a controller.

The initialization could be moved into cbqri_resctrl_control_init()
before any early return paths but it does introduce the possibility that
rid initialization could be missed if cbqri_resctrl_control_init() is
ever refactored. Given that, I'm inclined to keep the current structure.

Thanks,
Drew
