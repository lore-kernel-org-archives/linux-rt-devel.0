Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB94A371D15;
	Fri,  3 Jul 2026 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065629; cv=none; b=nbPoIdxYkObCroxtqAePWbTCjILhIxRUmjQFqlvpOR07ct+CX24MnLlafpPtZP75aYC7F08fflt5yoAth8jJ/BPmXCP8PaoWUDlPayQ/XfYNw12x4bw0J1vKiE9eDq7BgXWAjo/3p/VkjOPxDf0HC2SyF8ZLBdZW045/96FNqNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065629; c=relaxed/simple;
	bh=g4JQuhHD/RK6GHrhnwml/L/+nYMSlIjvihkKG4F2kk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcyYWGtHvE4k5YB59HcW//bqvdnESLX9egooHOqIdLzSiKhMpKYqB39ujyn1x9x3+nGRGWzgvChroV8WZralYiue9Wvn3ZLj6ch7KgjPrVmbLc3QW7hw8mtX2ryhgfdvAQGQh3Nw8fexNB9B6Kk1bVL653F2LG5DPH/NZPL7op0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gF2rbx1p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gF2rbx1p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01171F000E9;
	Fri,  3 Jul 2026 08:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783065627;
	bh=N6cvB6ilYfXF9Z+EldI441PSyI9lUhF0hrtl69qJt7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gF2rbx1ppjqa9+2qsNeLPi+Dr2B6uYU5jU8z5gb2wDPgIeKuRlItYFkeO0++ERkLy
	 WPvyzPIjbipYpLrP67Ua4EXeUGGJAARcis1cpcHOZ7OgxypilI6yvDTW/4Os0pCDTR
	 Z7GmHDUQMB7BLPxVBNMicUYmFuqzJF9mbFZU+6XCsunk4+/GlRX7snOL6wXVMWrnE5
	 YWq6SdeWTqgCc8LOAZ9uRPf43Ho1otnVSXVTUDl4WKTMh60V2Wrn2HJ60Jy3GJ+43u
	 Wi1jX8hHDHYsBtIgrVL7mAbyxfChNsCoFG0jZBO4T3eCLC05Ig28n1JXtNZtyECWN7
	 aKPO4wDGwEZ+A==
Date: Fri, 3 Jul 2026 01:00:25 -0700
From: Drew Fustini <fustini@kernel.org>
To: Fenghua Yu <fenghuay@nvidia.com>
Cc: Adrien Ricciardi <aricciardi@baylibre.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Atish Patra <atish.patra@linux.dev>,
	Babu Moger <babu.moger@amd.com>, Ben Horgan <ben.horgan@arm.com>,
	Borislav Petkov <bp@alien8.de>, Chen Pei <cp0613@linux.alibaba.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
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
	yunhui cui <cuiyunhui@bytedance.com>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, x86@kernel.org,
	devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 5/8] riscv_cbqri: resctrl: Add cache allocation via
 capacity block mask
Message-ID: <akdsGZm8e9w5idhn@x1>
References: <20260628-dfustini-atl-sc-cbqri-dt-v3-0-c9c1342fe3cf@kernel.org>
 <20260628-dfustini-atl-sc-cbqri-dt-v3-5-c9c1342fe3cf@kernel.org>
 <473da771-b711-457b-b9ad-491fee111b16@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <473da771-b711-457b-b9ad-491fee111b16@nvidia.com>

On Wed, Jul 01, 2026 at 01:18:41PM -0700, Fenghua Yu wrote:
> Hi, Drew,

Hi, thanks for reviewing.

> Could you please change my email address to my NVIDIA email
> fenghuay@nvidia.com?

No problem.

> On 6/28/26 14:18, Drew Fustini wrote:
> > Wire CBQRI capacity controllers into resctrl as RDT_RESOURCE_L2 and
> > RDT_RESOURCE_L3 schemata.
> > 
> > Mismatched CC caps at the same cache level are treated as a fatal
> > configuration error since fs/resctrl exposes a single per-rid cap
> > set. Domains are created lazily in the cpuhp online callback so
> > cpu_mask reflects only currently online CPUs.
> > 
> > Assisted-by: Claude:claude-opus-4-7
> > Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> >   MAINTAINERS                      |   2 +
> >   arch/riscv/include/asm/resctrl.h | 147 ++++++++
> >   drivers/resctrl/Kconfig          |   4 +
> >   drivers/resctrl/Makefile         |   1 +
> >   drivers/resctrl/cbqri_resctrl.c  | 787 +++++++++++++++++++++++++++++++++++++++
> >   5 files changed, 941 insertions(+)
> [SNIP]
> 
> > +/*
> > + * Walk cbqri_controllers and pick one capacity controller (CC) per cache
> > + * level (L2/L3) to back the corresponding RDT_RESOURCE_L*. When more than
> > + * one CC sits at the same level (e.g. one per socket), they must agree on
> > + * rcid_count / ncblks / alloc_capable. A mismatch is fatal because resctrl
> > + * exposes a single set of caps per rid. The first matching controller wins.
> > + */
> > +static int cbqri_resctrl_pick_caches(void)
> > +{
> > +	struct cbqri_controller *ctrl;
> > +	int ret = 0;
> > +
> > +	mutex_lock(&cbqri_controllers_lock);
> 
> Is it better to change mutex_lock()/mutex_unlock() to
>  guard(mutex)(&cbqri_controllers_lock)?
> 
> 1. This code is simpler and can avoid potential missing unlock issue.
> 2. This matches mpam code.

Good point, I will switch cbqri_controllers_lock lock/unlock to
guard(mutex).

> 
> > +
> > +	list_for_each_entry(ctrl, &cbqri_controllers, list) {
> > +		struct cbqri_resctrl_res *cbqri_res;
> > +		int rid;
> > +
> > +		if (ctrl->type != CBQRI_CONTROLLER_TYPE_CAPACITY)
> > +			continue;
> > +		if (!ctrl->alloc_capable)
> > +			continue;
> > +
> > +		rid = cbqri_cache_level_to_rid(ctrl->cache.cache_level);
> > +		if (rid < 0) {
> > +			pr_info("skipping controller at unsupported cache level %u\n",
> > +				ctrl->cache.cache_level);
> > +			continue;
> > +		}
> > +
> > +		cbqri_res = &cbqri_resctrl_resources[rid];
> > +		if (cbqri_res->ctrl) {
> > +			/*
> > +			 * CCs at the same cache level must agree on every cap
> > +			 * resctrl exposes globally. Reject mismatches at pick
> > +			 * time so the inconsistency is visible at boot.
> > +			 */
> > +			if (cbqri_res->ctrl->rcid_count != ctrl->rcid_count ||
> > +			    cbqri_res->ctrl->cc.ncblks != ctrl->cc.ncblks ||
> > +			    cbqri_res->ctrl->cc.supports_alloc_at_code !=
> > +				    ctrl->cc.supports_alloc_at_code ||
> > +			    cbqri_res->ctrl->alloc_capable != ctrl->alloc_capable) {
> > +				pr_err("L%d controllers have mismatched capabilities\n",
> > +				       ctrl->cache.cache_level);
> > +				ret = -EINVAL;
> > +				break;
> 
> Is it possible to support cbqri on both L2 and L3 on the same machine?
> Failure on one controller will stop picking another other controller here.
> 
> If both L2 and L3 can be supported on the same machine, does it make sense
> to pr_err() (fatal for this controller) and continue to go to the next
> controller? So failure on L2 won't impact L3?
> 
> If that's the case, does it make sense not to return error for
> pick_caches()? So pick_caches() failure is not fatal?

Yes, both L2 and L3 can be present at once, and you're right that this
approach was too strict. I will change it so that it drops only the
offending cache level. I will make pick_caches() clear that rid so it is
not exposed and continue to the next controller. It no longer returns an
error, so an L2 mismatch leaves L3, and any future QoS feature untouched.

[..]
> > +static int cbqri_attach_cpu_to_all_ctrls(unsigned int cpu)
> > +{
> > +	struct cbqri_controller *ctrl;
> > +	int err = 0;
> > +
> > +	lockdep_assert_held(&cbqri_domain_list_lock);
> > +
> > +	/*
> > +	 * Hold cbqri_controllers_lock across the walk so a controller
> > +	 * registered after boot cannot corrupt it. The register path takes
> > +	 * it as a leaf and never cbqri_domain_list_lock, so this nesting
> > +	 * cannot invert.
> > +	 */
> > +	mutex_lock(&cbqri_controllers_lock);
> 
> guard(mutex)(&cbqri_controllers_lock)?

Ack.

> > +static int cbqri_resctrl_setup(void)
> > +{
> > +	int rid;
> > +	int err;
> > +
> > +	for (rid = 0; rid < RDT_NUM_RESOURCES; rid++)
> > +		cbqri_resctrl_resources[rid].resctrl_res.rid = rid;
> > +
> > +	err = cbqri_resctrl_pick_caches();
> > +	if (err)
> > +		return err;
> 
> Failure in pick_caches() will abort any future cbqri features e.g. memory bw
> allocation/monitoring. Is it possible to ignore the pick_caches() failure
> and continue to setup other cbqri features? Failed caches won't impact other
> QoS features, right?

You're right, and this is the same change as the L2/L3 mismatch above. I
will drop the error return from pick_caches() so that a cache problem can
no longer abort setup or block other QoS features. Cache capacity and
memory bandwidth are separate controller types that will be picked
independently, so a failed cache will not gate bandwidth alloc/mon when
those land. The only early return I will keep is the -ENODEV for when
nothing at all is exposable.

Thanks,
Drew
