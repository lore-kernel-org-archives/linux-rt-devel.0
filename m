Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D5640D59C;
	Mon, 20 Jul 2026 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567576; cv=none; b=couvcGtQiwWMzZz0n6DvYtAmRxnUcEg5xYdNncH93KTMIyFi2zNd4/+m9mZjTPH7X0BHFufH+5oHUZflZ3gFQcNK0JvaEkojOmdnhzmPlnLaFlqpVa5+PXpwAeKA43VNgT/0EsI9FFWW1dDd6Nn5Dwb32cevn6AiMoZT/wUIzp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567576; c=relaxed/simple;
	bh=mWA/LFdWld21e+cruzH33uEt4i+3Kd6+JAuX3m1Fy4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKJSROc/z9dfxyw8WayYSmyNOCoU96JqAsNVpdRkOVRtr+ouFwI0hqRqwkrPqWOQcUClRgSwoj3qaGBt4z2DmxQnODEaYhsbidJyIYljh+V7XH3oKkrmN6oPNJp6PkG6B1O4VkIfp2hKuT40/uMPm1IbChd8/DsM6Q2/BQSCdEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6PUV/3u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6PUV/3u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B3C1F000E9;
	Mon, 20 Jul 2026 17:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784567569;
	bh=oJNfS8d+wz6ZwMhpRurQqnssE2zcvL/b/o4Ai+J3GrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c6PUV/3umndlldj6PU8H8U5Pza3QJ5cYCHJM/EgPWEFN+hY3MzkCJG0m92X2uL/Hu
	 z1r1I52zaz0lkYC+mmODg2tmSMUibs9RnxMnf+ggetKU6Eo8Yv2wFBgo7Xm0IDNgbt
	 RD7m7b4VWlIrKHJuaaT9GBOK5PJaPzpOT8Qxf4r4ZhDI/cLDwKT1USJRgOOdYDvQyD
	 x2re0svsspMf7/NKhB/nnf/ECutHRzKTkaagawaYiup7BsYda0WFYRbtnUs3ME4pap
	 n4d6Z614BaWJ17i5IQHyrjY22NW1Rta7BNWj2FjESYc2vkU8frzDpo9VOU29IhNnMv
	 2/B0cifWy2tgQ==
Date: Mon, 20 Jul 2026 10:12:47 -0700
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
Message-ID: <al5XD5UbluV_NyE3@thelio>
References: <20260714-dfustini-atl-sc-cbqri-dt-v5-0-b0ae7e9c932e@kernel.org>
 <20260714-dfustini-atl-sc-cbqri-dt-v5-4-b0ae7e9c932e@kernel.org>
 <CAEEQ3w=9JKswTz9BcxXRvLh-kyN_Rdu3=YUR5Rey2J9UNyd0AA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3w=9JKswTz9BcxXRvLh-kyN_Rdu3=YUR5Rey2J9UNyd0AA@mail.gmail.com>

On Mon, Jul 20, 2026 at 08:12:28PM +0800, yunhui cui wrote:
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
[..]
> > +static int cbqri_probe_cc(struct cbqri_controller *ctrl)
> > +{
> > +       int err, status;
> > +       int ver_major, ver_minor;
> > +       u64 reg;
> > +
> > +       reg = cbqri_readq(ctrl->base + CBQRI_CC_CAPABILITIES_OFF);
> > +       if (reg == 0)
> > +               return -ENODEV;
> > +
> > +       ver_minor = FIELD_GET(CBQRI_CC_CAPABILITIES_VER_MINOR_MASK, reg);
> > +       ver_major = FIELD_GET(CBQRI_CC_CAPABILITIES_VER_MAJOR_MASK, reg);
> > +       ctrl->cc.ncblks = FIELD_GET(CBQRI_CC_CAPABILITIES_NCBLKS_MASK, reg);
> > +
> > +       pr_debug("version=%d.%d ncblks=%d cache_level=%d\n",
> > +                ver_major, ver_minor,
> > +                ctrl->cc.ncblks, ctrl->cache.cache_level);
> > +
> > +       /*
> > +        * NCBLKS == 0 would divide-by-zero in the schemata math while
> > +        * ctrl->lock is held.
> > +        */
> > +       if (!ctrl->cc.ncblks) {
> > +               pr_warn("CC at %pa has 0 capacity blocks, skipping\n",
> > +                       &ctrl->addr);
> > +               return -ENODEV;
> > +       }
> > +
> > +       if (ctrl->cc.ncblks > 32) {
> > +               pr_warn("CC at %pa has ncblks=%u > 32 (resctrl CBM is u32), skipping\n",
> > +                       &ctrl->addr, ctrl->cc.ncblks);
> > +               return -ENODEV;
> > +       }
> 
> Could you add a short comment here, like MPAM does, to note that the
> NCBLKS <= 32 limit comes from resctrl using u32 bitmap configs?

Sure, I will add a comment that the limit comes from resctrl
representing the CBM as a u32.

Thanks,
Drew
