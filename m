Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D25EEC0;
	Fri, 25 Sep 2026 00:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790296148; cv=none; b=eyKK6o/VrL3o+WA92IBaBoZS42GaMqEDs07p8ZkZ/LgQ1jiFOefwRx0tZE1qUrgZ5lv075Xt8dYrIbBBmJWkmJAniLzQOVadui//lQB+Q8R3n/bMpDpvoMJpUaYqWeGh9ywmLC9COxOJXIe99yJBw2JWapPbVwR4f9S4MHtPZfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790296148; c=relaxed/simple;
	bh=bns/bIbNlR6oTaMwRKkbC3IgfoVj9FPuCc75fiFh/n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1kQZg5vbZ/w3cAV+rylwdzzrEB5nF+Kxk8fHCik8YLQ+jFgkPWXyY2Qy4OGqeReufjcECPckod5AOvXKoBQ+w3EGRVYBBOVVkLIl9qKF8rr3qkuOFub1xGVOqSZ0qIQbbbk8I3CYwD6ohRd9YwkM13ACHunk4BwRFgwwWReaP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4aIuWZW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4aIuWZW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315411F000FF;
	Fri, 25 Sep 2026 00:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790296146;
	bh=DVBRdfN8FrtxutACwQNau7GOnf++xs028/3aBNx68Es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g4aIuWZW7sdIp7OgfBRDtk2ahfICsbZWX7rEgQPmePr2OWs5ndM+ZAq44I/PCg3Me
	 LJdlaTwYmoReDzi3DdlhfDywY98cChu6idNLfwQkRz9597aZ4svccHWyTObrsmQ14l
	 rs5T+ot4sjmB+4QuchkCF9I6Dis1VqLzkoWxN2ujJ3xFvskPclRqWkLkEqDl2vCCAJ
	 Y6RcsMg+U9aY3FUY6uITm5i7vnGd8zIasb3XqUNz8YzHb0Agr9b5ivqDjmg9R399ab
	 Wp2b+o3hbRArxi7531q4B4UWkynPFRlP/MjHEnx1j496MBmmLuC/qRR6P10QT5xSKf
	 8TiLBUqrSms/g==
Date: Thu, 24 Sep 2026 17:29:05 -0700
From: Drew Fustini <fustini@kernel.org>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Adrien Ricciardi <aricciardi@baylibre.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>,
	Atish Kumar Patra <atishp@rivosinc.com>,
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
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	x86@kernel.org, devicetree@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 2/5] riscv_cbqri: resctrl: Add cache allocation via
 capacity block mask
Message-ID: <arXAUafBYERE7clK@thelio>
References: <20260917-dfustini-atl-sc-cbqri-dt-v8-0-7964e8d73fe8@kernel.org>
 <20260917-dfustini-atl-sc-cbqri-dt-v8-2-7964e8d73fe8@kernel.org>
 <CAEEQ3w=pDjEGfMtHUamxLFa0+qYuZ=od0OhAUH7_h+ybMAiO4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3w=pDjEGfMtHUamxLFa0+qYuZ=od0OhAUH7_h+ybMAiO4g@mail.gmail.com>

On Wed, Sep 23, 2026 at 05:13:15PM +0800, yunhui cui wrote:
> Hi Fustini,
> 
> On Fri, Sep 18, 2026 at 12:41 AM Drew Fustini <fustini@kernel.org> wrote:
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
> > Control domains are created in the cpuhp online callback and keyed on
> > the onlining CPU's cache id from cacheinfo, so a CPU that is offline at
> > probe time still joins its domain once it comes online. A domain is
> > published on the ctrl_domains RCU list only after it is fully
> > initialized and brought online, and removed from the list before it is
> > taken offline, following the documented safe traversal rules.
> >
> > Assisted-by: LLM
> > Tested-by: Chen Pei <cp0613@linux.alibaba.com>
> > Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> >  MAINTAINERS                      |   2 +
> >  arch/riscv/include/asm/resctrl.h | 147 ++++++++
> >  drivers/resctrl/Kconfig          |   4 +
> >  drivers/resctrl/Makefile         |   1 +
> >  drivers/resctrl/cbqri_resctrl.c  | 785 +++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 939 insertions(+)
[..]
> > diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_resctrl.c
[..]
> > +/*
> > + * Note about terminology between x86 (Intel RDT/AMD QoS) and RISC-V:
> > + *   CLOSID on x86 is RCID on RISC-V
> > + *     RMID on x86 is MCID on RISC-V
> > + */
> > +u32 resctrl_arch_get_num_closid(struct rdt_resource *res)
> > +{
> > +       struct cbqri_resctrl_res *hw_res;
> > +
> > +       hw_res = container_of(res, struct cbqri_resctrl_res, resctrl_res);
> > +
> > +       if (!hw_res->ctrl)
> > +               return 0;
> > +
> > +       return hw_res->ctrl->rcid_count;
> > +}
> 
> When CDP is enabled, the resctrl core halves the value returned by
> resctrl_arch_get_num_closid(). Is that correct for CBQRI?
> CBQRI v1.0 defines allocation using an (RCID, AT) pair, and its example
> uses the same RCID=5 for separate AT=0 and AT=1 allocations.
> 
> Thanks,
> Yunhui

You're right that this is not needed for RISC-V. CDP is still functional
but the upper half of RCIDs is unused.

It would require an fs/resctrl change to make the halving conditional.
Therefore, I would like to deal with that in a separate series and not
expand the scope of this series. I will add a comment above
resctrl_arch_get_num_closid() for v9, so the current situation is
obvious.

Thanks,
Drew
