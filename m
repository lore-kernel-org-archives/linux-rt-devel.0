Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C13D3B3C0F;
	Sun, 12 Jul 2026 19:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783883705; cv=none; b=MWppHIb1TX+OUuBMmUErSuimNL6g6bYYKmXbnFOKZhH/GDD16xgIAb2EiOjO4sKWQndxp06tG99Ghvl6KOk1vepEoeI/r+PvpaK7j0eUDQykvXLbP/EnH8ETBPjKLQJLHX8WHo0BP0/55xiHNBdu5VBFC3xSgyLB9CdQxCX7jlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783883705; c=relaxed/simple;
	bh=ikd+TViXq28E5vHcA0r9IRmr5s/Pv4K7YRHMB6XfEAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzScFC9YK672L+lb1nwyc0xhxTdO7DiXAnMXOftMbYDf1d2L8ckcbszuZTMnjJPw7mRTCi+YR51XVR613h8EzXOnTBdDZ3khTCn8nM43y3dilCTWfGFYeu4a9XJGheO1F59QGLmZQECcrSnVz20kocyjKzUEUdhlbd4PIKyzpug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+1O9GP1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+1O9GP1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B0A1F000E9;
	Sun, 12 Jul 2026 19:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783883704;
	bh=73b4pL2XQtnec2/Fy5ja53Ba+xumzUzAkyQQn/NfjQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A+1O9GP1ucy3KjYEern4zyQU/VnyDWPh8PtiWqJT8ty6GYQZqbKu1DkSIavsJncpD
	 y3RZOJt5cI+dOZnoZefjzOrN+aUrcYds6YmyMBOdD8ssSPDV63Qs7o22SDqmlSGLjp
	 umHQkoGwuBXkG2XG/EBnZ5+nkhIVtfYEXUtgGxWSatDlouhoNvsxnqqwrANc4Ppo4Q
	 XmcRRIf8VIiN5HosFT/oTtM3/zjkNmI/IapPKXbFOfWY2+Dan3wVUw1AqY0v6nEmZt
	 bGtHO4VTdUx30RXwrWDrLT7NgTHC47U+uf//4DgQpir0YXJ9Ho+XxNYaTEiUEu1h6b
	 fwbdSyh1O4DQA==
Date: Sun, 12 Jul 2026 12:15:02 -0700
From: Drew Fustini <fustini@kernel.org>
To: Reinette Chatre <reinette.chatre@intel.com>
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
Subject: Re: [PATCH v4 5/8] riscv_cbqri: resctrl: Add cache allocation via
 capacity block mask
Message-ID: <alPntkIPbl17bEiD@x1>
References: <20260706-dfustini-atl-sc-cbqri-dt-v4-0-e75c20201d64@kernel.org>
 <20260706-dfustini-atl-sc-cbqri-dt-v4-5-e75c20201d64@kernel.org>
 <3e7070fa-16f3-453e-9f0e-9c1a2ef38f9f@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e7070fa-16f3-453e-9f0e-9c1a2ef38f9f@intel.com>

On Tue, Jul 07, 2026 at 11:17:14AM -0700, Reinette Chatre wrote:
> Hi Drew,

Thanks for reviewing and your suggestions.

> On 7/6/26 4:06 PM, Drew Fustini wrote:
> 
> ...
> 
> > diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_resctrl.c
> > new file mode 100644
> > index 000000000000..cb12a868561b
> > --- /dev/null
> > +++ b/drivers/resctrl/cbqri_resctrl.c
> 
> ...
> 
> > +
> > +/*
> > + * fs/resctrl unconditionally references the symbols below before checking
> > + * mon_capable. They are stubs for features CBQRI does not yet support.
> > + */
> 
> resctrl should not access monitoring related arch functions if the arch
> does not support monitoring. Could you please highlight which ones are causing
> problems? From what I can tell, the first one below, resctrl_arch_is_evt_configurable(),
> is indeed only called via resctrl_l3_mon_resource_init() if the L3 resource is
> mon_capable.

You are right, none of the monitoring stubs run for the allocation-only
CBQRI implementation in this series. The stubs exist only so fs/resctrl
resolves the symbols at link time. I'll drop the comment.

> > +bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt)
> > +{
> > +	return false;
> > +}
> > +
> > +void *resctrl_arch_mon_ctx_alloc(struct rdt_resource *r,
> > +				 enum resctrl_event_id evtid)
> 
> Similarly, this should only be called when reading monitoring data which should only be
> possible if the resource is capable of monitoring.

Agreed, same as above.

> > +/*
> > + * Walk cbqri_controllers and pick one capacity controller (CC) per cache
> > + * level (L2/L3) to back the corresponding RDT_RESOURCE_L*. When more than
> > + * one CC sits at the same level (e.g. one per socket), they must agree on
> > + * rcid_count / ncblks / alloc_capable. A level whose controllers disagree
> > + * is dropped, since resctrl exposes a single set of caps per rid, but the
> > + * other level is still picked. The first matching controller wins.
> > + */
> 
> It works but I find it to be a potentially confusing approach (just a personal opinion!).

Good point. I'll restructure it to pick per cache level instead of per
controller, which removes the separate dropped[] array and the
overloaded NULL that made it confusing.

> > +static struct rdt_ctrl_domain *cbqri_create_ctrl_domain(struct cbqri_controller *ctrl,
> > +							struct rdt_resource *res,
> > +							unsigned int cpu, int dom_id)
> > +{
> > +	struct rdt_ctrl_domain *domain;
> > +	struct list_head *pos = NULL;
> > +	int err;
> > +
> > +	domain = cbqri_new_domain(ctrl);
> > +	if (!domain)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	cpumask_set_cpu(cpu, &domain->hdr.cpu_mask);
> > +	domain->hdr.id = dom_id;
> > +	domain->hdr.type = RESCTRL_CTRL_DOMAIN;
> 
> Please also initialize domain->hdr.rid that is referenced by the often-used 
> domain_header_is_valid() helper.

Okay, I will set 'domain->hdr.rid = res->rid'.

> > +
> > +	err = cbqri_init_domain_ctrlval(res, domain);
> > +	if (err) {
> > +		kfree(container_of(domain, struct cbqri_resctrl_dom,
> > +				   resctrl_ctrl_dom));
> > +		return ERR_PTR(err);
> > +	}
> > +
> > +	/* Insert sorted by id so user-visible ordering is deterministic. */
> > +	resctrl_find_domain(&res->ctrl_domains, dom_id, &pos);
> > +	list_add_tail(&domain->hdr.list, pos);
> 
> The domain list became an RCU list when resctrl started supporting MPAM. 
> commit fb700810d30b ("x86/resctrl: Separate arch and fs resctrl locks") contains
> a great description of the motivation and the different accesses that the list
> should support. Historically resctrl always accessed the list with CPU hotplug lock
> held for which above is ok but there are some planned changes as part of a fix
> that accesses the list via an RCU read-side critical section. Even with this addition
> there is no immediate impact to this enabling since it is related to the
> MBA software controller but I think it is best for archs and resctrl to agree on
> how the domain list can be accessed safely.
> 
> For reference to the upcoming resctrl usage see
> https://lore.kernel.org/lkml/4c88e01e29df638d9ecad71b2ee3b411e24067bd.1783377598.git.reinette.chatre@intel.com/
>
> > +
> > +	resctrl_online_ctrl_domain(res, domain);
> 
> With the transition to RCU list the domain should only be added to the list after it is
> fully initialized.

Thanks for the explanation. I will adopt the RCU list convention. Fully
initialize the domain, online it, and then publish it.

> > +static void cbqri_detach_cpu_from_ctrl_domains(struct rdt_resource *res,
> > +					       unsigned int cpu)
> > +{
> > +	struct rdt_ctrl_domain *domain, *tmp;
> > +
> > +	list_for_each_entry_safe(domain, tmp, &res->ctrl_domains, hdr.list) {
> > +		if (!cpumask_test_cpu(cpu, &domain->hdr.cpu_mask))
> > +			continue;
> > +		cpumask_clear_cpu(cpu, &domain->hdr.cpu_mask);
> > +		if (cpumask_empty(&domain->hdr.cpu_mask)) {
> > +			resctrl_offline_ctrl_domain(res, domain);
> > +			list_del(&domain->hdr.list);
> 
> (also related to switch to RCU list, remove domain from list before
> starting to offline it)

Will do, thanks.

> > +			kfree(container_of(domain, struct cbqri_resctrl_dom,
> > +					   resctrl_ctrl_dom));
> > +		}
> > +	}
> > +}
> 
> How CPUs are associated with control domains are not clear to me. Above appears to
> be consequence of how platform driver initializes so I will comment more there (patch #8).
> Just for above, it is unexpected that a CPU needs to be tested against cpu_mask
> of all control domains. Would a direct query that uses the CPU's cache ID not be
> quicker? Also, above creates impression that a CPU may belong to multiple control
> domains which should not happen.

Thanks for the suggestion. I will change it to lookup the domain up directly by
the cache id.

> > +/*
> > + * Attach a CPU to every controller that claims it. On failure, detach the
> > + * CPU from everything attached so far: the cpuhp core does not run this
> > + * state's offline teardown when its startup fails, so a partial attach
> > + * would otherwise leak into the domain cpu_masks. Caller holds
> > + * cbqri_domain_list_lock.
> > + */
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
> > +	guard(mutex)(&cbqri_controllers_lock);
> > +	list_for_each_entry(ctrl, &cbqri_controllers, list) {
> > +		if (ctrl->type != CBQRI_CONTROLLER_TYPE_CAPACITY)
> > +			continue;
> > +		if (!cpumask_test_cpu(cpu, &ctrl->cache.cpu_mask))
> > +			continue;
> 
> What will happen if @cpu was offline when cbqri_capacity_probe() ran? From what
> I can tell @cpu will not be in ctrl->cache.cpu_mask in this scenario?

Yes, this is a problem. I will drop the probe-time cpu_mask and associate cpus
with domains the way you suggest, from the cpu's own cache id at hotplug time.

Thanks,
Drew
