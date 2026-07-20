Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCB0625;
	Mon, 20 Jul 2026 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567416; cv=none; b=igiQNnv7o5Fd/Ha8WhPVF27/X4CifQgvymWclPKNf0c6Yw+jisvNPQUt0YdaWloSkBnreJ/HbPCNBbkXGgCSm1VGKlfwd8QCEyL+JfeZh3vcoeaqgK01myxCw3WghlTyx/vX+4r3Di372ta4MVt31J01q/nVTl4B6sjHIEzhIbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567416; c=relaxed/simple;
	bh=y78gdP4Mhf4DF9a087GDBf+ZMhh7EhPFI++5A5Fodco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9U1J4sEk+vrDcw1aD8nQm2bIZBhaDZIwrhpfY7KaNTsR3apRN1uHaSxJblhJwMrBgXOz3yxYxYHBULDfHt7zP+xckydCy1pSjbj8kuA+slJnjc5dClgEpLLTcSzyn4I9xVFmOHk/lSfG242FlbZXcrLWCVL3TyV1WiQNE7SbuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itoK4Mdj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itoK4Mdj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03961F000E9;
	Mon, 20 Jul 2026 17:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784567407;
	bh=BjfOV+NKNZXLs5UViExwi4UTvSENVwLsFID1r6Q/kEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=itoK4Mdjj5ii0LNFWHvWvZeKb1bM5ZWQY2SLjLXjkfO1feztT6Gn6G8NiVOat+KPg
	 0D/NB12mkVZe0Qu8dpRL0oONt2wA5dLQq2HFtDJt5+6MzcZEUaN8ebT6E6dQey+8Bv
	 U67NhgIIVjM0yZ2RgwCjpyBriixC3kOUjNzXDQkdhvIe5nvIncSc+M1s1QCf4Glnzw
	 79N0nsDl390dkbxedNNurbefhulS5jWgAZhH6RiSFZ8JtYiyqnIGyKYLSKviEh1SQL
	 11vzxbZo4cCDnI1BgewLbszrJZvcJRudTbDKrMrm+59/LFG+1WpbrwjdfmaUCqah49
	 bbOMVK1BbfpDw==
Date: Mon, 20 Jul 2026 10:10:05 -0700
From: Drew Fustini <fustini@kernel.org>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Adrien Ricciardi <aricciardi@baylibre.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
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
	Tony Luck <tony.luck@intel.com>,
	Vasudevan Srinivasan <vasu@rivosinc.com>,
	Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li <liwei1518@gmail.com>,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	x86@kernel.org, devicetree@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org
Subject: Re: [External] [PATCH v5 4/8] riscv_cbqri: Add capacity controller
 probe and allocation device ops
Message-ID: <al5WbTyTVYye70LW@thelio>
References: <20260714-dfustini-atl-sc-cbqri-dt-v5-0-b0ae7e9c932e@kernel.org>
 <20260714-dfustini-atl-sc-cbqri-dt-v5-4-b0ae7e9c932e@kernel.org>
 <CAEEQ3w=kVgMnQ8mu=X+d3xYbANT6dNfv7w71BUwmYxP6qcUhgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3w=kVgMnQ8mu=X+d3xYbANT6dNfv7w71BUwmYxP6qcUhgg@mail.gmail.com>

On Mon, Jul 20, 2026 at 05:56:29PM +0800, yunhui cui wrote:
> Hi Drew,
> 
> On Wed, Jul 15, 2026 at 8:24 AM Drew Fustini <fustini@kernel.org> wrote:
> >
> > Add support for the RISC-V CBQRI capacity controller. A platform driver
> > passes a cbqri_controller_info descriptor together with the cache level
> > to riscv_cbqri_register_cc_dt(), which probes the controller and adds it
> > to the controller list.
> >
> > Assisted-by: Claude:claude-opus-4-8
> > Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> >  MAINTAINERS                      |   3 +
> >  drivers/resctrl/Kconfig          |  13 +
> >  drivers/resctrl/Makefile         |   3 +
> >  drivers/resctrl/cbqri_devices.c  | 563 +++++++++++++++++++++++++++++++++++++++
> >  drivers/resctrl/cbqri_internal.h | 122 +++++++++
> >  include/linux/riscv_cbqri.h      |  45 ++++
> >  6 files changed, 749 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a0a4b41f02c5..064a6ae2823e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -23365,6 +23365,9 @@ L:      linux-riscv@lists.infradead.org
> >  S:     Supported
> >  F:     arch/riscv/include/asm/qos.h
> >  F:     arch/riscv/kernel/qos.c
> > +F:     drivers/resctrl/cbqri_devices.c
> > +F:     drivers/resctrl/cbqri_internal.h
> > +F:     include/linux/riscv_cbqri.h
> >
> >  RISC-V RPMI AND MPXY DRIVERS
> >  M:     Rahul Pathak <rahul@summations.net>
> > diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
> > index 672abea3b03c..92b9c82cf9f3 100644
> > --- a/drivers/resctrl/Kconfig
> > +++ b/drivers/resctrl/Kconfig
> > @@ -29,3 +29,16 @@ config ARM64_MPAM_RESCTRL_FS
> >         default y if ARM64_MPAM_DRIVER && RESCTRL_FS
> >         select RESCTRL_RMID_DEPENDS_ON_CLOSID
> >         select RESCTRL_ASSIGN_FIXED
> > +
> > +menuconfig RISCV_CBQRI
> > +       bool "RISC-V CBQRI support"
> > +       depends on RISCV && RISCV_ISA_SSQOSID
> > +       help
> > +         Capacity and Bandwidth QoS Register Interface (CBQRI) support for
> > +         RISC-V cache QoS resources. CBQRI exposes cache capacity
> > +         allocation through the resctrl filesystem at /sys/fs/resctrl when
> > +         RESCTRL_FS is also enabled.
> > +
> > +if RISCV_CBQRI
> > +
> > +endif
> 
> Should this empty if/endif block go in patch [8/8] instead?

Good point. I'll move it to patch 8.

Thanks,
Drew
