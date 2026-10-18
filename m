Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625173A1E80;
	Sun, 18 Oct 2026 06:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792304662; cv=none; b=DxJhQVCrM08eqKx2chE55WdjRfp/fcmGTFitTTKeZtH3KhfiuMg8hKmz4MH41n91Xif/9eK2/Ugloo2GPWSE6HDheNXKQcGkSCZa2p8YoP4V4o6o8AAqOJNw/5Rk/DtUVXaIAu37nj4Yz3YHuuGoGHtN8OoAuFJV4rCwVq33Ra8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792304662; c=relaxed/simple;
	bh=/agrnax0wfksccKHgEoBGnRbFp7OLiMy5dYjThZCV3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laLTFZ0L8EZtYibBQZssoj7jd0mVxO66dr9IpZMNj1jnDWhfKquCcGMmPlyiqE6zP3iBjCDJ47Xt3smhd/pN0+vp6fZBbLQim9fRP3mp+3H2XezU8gSR20e6LXLRnJt+x6erH5WZD4yZN4h11BfGyU8VeFSJ9P3Dt7yspp9meVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePeHDgCz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePeHDgCz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CA51F000C4;
	Sun, 18 Oct 2026 06:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792304660;
	bh=w2Qw0jIYjCcszsE1XhibnTlIkBb9EQqyKTQh4sDtAhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ePeHDgCzDAgLo5tVEJsA16jTv75lNDD4irGGQJwjWhGDdajzpwDF1XoZKX2cH8FKG
	 6+84L4TEf90k5sfW+5L0TxhPmVmwCWlmu6H+ZGx8D0RX67pZp744hZPBx9G1cHMBot
	 UdMQaY3PzH1HKDwkxskY0TPGkM4ms2SL1DZcxvgCbnagZIRlGcBPr0XL7gbNWxaaQf
	 JAsWz6BXTpZdRev/RVo/hBr4Zj8ghnrg0namZ1kxJS40CHQhfFnLtZ57xyk73av15d
	 ZCXRYLjrG5uGL7EwCp1kRZbF1khfUAb/o+8QTP4rJ9tHcijYsoX88mHRWVDalZCG4O
	 u5IIlWgJaAxvA==
Date: Sat, 17 Oct 2026 23:24:19 -0700
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
Subject: Re: [PATCH v9 5/5] riscv_cbqri: Add CBQRI capacity allocation
 platform driver
Message-ID: <atRmE5lKNxmskzTm@thelio>
References: <20261003-dfustini-atl-sc-cbqri-dt-v9-0-52fd8be98dcf@kernel.org>
 <20261003-dfustini-atl-sc-cbqri-dt-v9-5-52fd8be98dcf@kernel.org>
 <CAB19ukEMKp7iFHrTPawNj2dwf1n0D9VDBC2ycBPdCRbkGYN2eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB19ukEMKp7iFHrTPawNj2dwf1n0D9VDBC2ycBPdCRbkGYN2eg@mail.gmail.com>

On Mon, Oct 12, 2026 at 10:33:21PM +0530, Sunil V L wrote:
> On Sat, Oct 3, 2026 at 12:45 PM Drew Fustini <fustini@kernel.org> wrote:
> >
> > Add a platform driver for CBQRI capacity controllers described in
> > device tree with the riscv,cbqri-capacity-controller compatible.
> >
> > The controller node points at the cache it governs with a
> > riscv,cbqri-cache phandle. The driver looks that cache up in cacheinfo
> > and uses its cache id as the resctrl domain id, so the binding does not
> > need to carry a CPU mask. The controller is then handed to the CBQRI
> > core, which probes its capabilities and decides whether to expose it
> > through resctrl.
> >
> > Nothing is vendor-specific and reg is the CBQRI register block itself,
> > so any SoC that describes a CBQRI capacity controller in device tree can
> > use the driver unchanged.
> >
> > Assisted-by: LLM
> > Tested-by: Chen Pei <cp0613@linux.alibaba.com>
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> >  MAINTAINERS                      |   1 +
> >  drivers/resctrl/Kconfig          |  15 +++++
> >  drivers/resctrl/Makefile         |   1 +
> >  drivers/resctrl/cbqri_capacity.c | 127 +++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 144 insertions(+)
[..]
> > diff --git a/drivers/resctrl/cbqri_capacity.c b/drivers/resctrl/cbqri_capacity.c
> > new file mode 100644
> > index 000000000000..0670a676bdb1
> > --- /dev/null
> > +++ b/drivers/resctrl/cbqri_capacity.c
[..]
> > +static int cbqri_capacity_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct cbqri_controller_info info = {};
> > +       struct device_node *cache_np;
> > +       struct resource *res;
> > +       u32 rcid_count, cache_level;
> > +       int cache_id, cpu, ret;
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       if (!res)
> > +               return -EINVAL;
> > +
> Unless I am missing something, I think you can simplify the code by
> using devm_platform_ioremap_resource().

Yes, I'll switch to devm_platform_get_and_ioremap_resource().

[..]
> > +
> > +       info.type = CBQRI_CONTROLLER_TYPE_CAPACITY;
> > +       info.addr = res->start;
> > +       info.size = resource_size(res);
> > +       info.rcid_count = rcid_count;
> > +       info.cache_id = cache_id;
> > +
> > +       ret = riscv_cbqri_register_cc_dt(&info, cache_level);
> >
> As I mentioned in the comment for another patch, this function doesn't
> need to have "_dt" in its name.

Good point, I'll drop it.

Thanks,
Drew
