Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792526857;
	b=P6zd2g9Y6DTzqKhKg6H3JYgw2mU5NGdl64USlB6lBJ3fxYopl7mZbZhjeZlWosQiK385
	 cmNIGtwnZmMerzVRfjVfN3B61adyA6O9Zq8bqvezGchez2i2P1d0dm78PDeSXviWUFf2k
	 WiNmLibM7AejCSTqM+v4dXlXv7GRDnw59D9hzD1EiE3fFfdHM1o3GocVthtyjLYawvR25
	 v8gVPg1z+czBFtkrW2+kxUs7pT1xAS7KG6+DX9lfO7IIBT4IGZfmCxuK29Er4m5ytulxL
	 J9vg8HLtBJOLLfizBy/LYIOHzpPbLia/yxJwleIJDkflGCczAWiaEuFQgqHXK9Das9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792526857;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=E2BGEbDmLFbyDFnjpJoQXmoXVufyoU6uu+OtS+on9zk=;
	b=hqex136JhiVNsROnywsqNl+LLJmV8Cc14F97aH/C1wtb9icl6M5PDeCm95yPWROmikub
	 W4vaqIufLil5ZchTjAvUtckknETcz9TmxVtMXxHy4UqLAsiIXHtbLRYuzoDr7leE3zdgW
	 fhEPJGsCBIEnoKULFUhVx0xjk3O8Xys+OU63p7u2JN2iJt81ZX5+hbYogY5KICYngsUNu
	 x0uDUitXw4IHItde66BKte8WUmoA3YLh0jIlO4rfP0fn9fCCG4AM2TCWArQwvg6QRVLBs
	 NAZPIggFu+Xn9YkBFqdViRsxxbojfzXmfeBgJmsbV/jLWOZpEbNQ05zFiDVnzy4TfFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H9uaiLSu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5748D606A319;
	Tue, 20 Oct 2026 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H9uaiLSu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427201F000C9;
	Tue, 20 Oct 2026 20:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792526856;
	bh=E2BGEbDmLFbyDFnjpJoQXmoXVufyoU6uu+OtS+on9zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H9uaiLSu6EN8ZMZq3/0JMSJPE29d2PjlBFMnCo4seWtCTz0f2ARFbSmnvnjmrbNbr
	 r22afbzsogdoWoQFtLND62nuBZ5boJ5Kq94KNgfb63qfNSi3Un1J8MO2aChHSJsMjZ
	 LyhNJL0TYaW/zhN/AcrBvXO/ahu6lOZpiOr3fAdXUD4sY2K4cYc/KAU8XklZJMtzu5
	 3tL7eaI8RBuZ8pUC/Pvf2+LSADAZDP8oJNwyWTdoqk1Zww7hynaKaD1pvJOQ5utyzL
	 2bP6TvWec1JC0u3mPd9wwV3QP3f3qqPGw5KGhj2x5vE5aPdAlN7qXa5mJQ/aAi5DNL
	 QBbisxdPEIJ9w==
Date: Tue, 20 Oct 2026 13:07:35 -0700
From: Drew Fustini <fustini@kernel.org>
To: Reinette Chatre <reinette.chatre@intel.com>
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
Message-ID: <atfKB-aHUdQAlmho@thelio>
References: <20261003-dfustini-atl-sc-cbqri-dt-v9-0-52fd8be98dcf@kernel.org>
 <20261003-dfustini-atl-sc-cbqri-dt-v9-2-52fd8be98dcf@kernel.org>
 <49444078-0777-4318-9f8b-0d582d8a29ad@intel.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49444078-0777-4318-9f8b-0d582d8a29ad@intel.com>

On Tue, Oct 20, 2026 at 11:37:52AM -0700, Reinette Chatre wrote:
> Hi Drew,

Hi, thanks for your comments and Ack.

> On 10/3/26 12:12 AM, Drew Fustini wrote:
> 
> ...
> 
> > diff --git a/arch/riscv/include/asm/resctrl.h b/arch/riscv/include/asm/resctrl.h
> > new file mode 100644
> > index 000000000000..867db663d958
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/resctrl.h
> 
> ...
> 
> > +/**
> > + * resctrl_arch_mon_ctx_alloc() - allocate per-monitor-event arch context
> > + * @r:     resctrl resource being monitored
> > + * @evtid: which monitor event needs context
> > + *
> > + * The CBQRI driver implements no monitoring events, so there is no per-event
> > + * context to allocate and the stub returns NULL. fs/resctrl references it
> > + * unconditionally before checking resctrl_arch_mon_capable().
> 
> The last sentence is unexpected. fs/resctrl only calls resctrl_arch_mon_ctx_alloc()
> from mon_event_read(), __check_limbo() and mbm_update_one_event(), and none of these
> can run on a system that does not support monitoring.

Good point, I will remove that final sentence.

> > + */
> > +void *resctrl_arch_mon_ctx_alloc(struct rdt_resource *r, enum resctrl_event_id evtid);
> > +
> > +/**
> 
> ...
> 
> > diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_resctrl.c
> > new file mode 100644
> > index 000000000000..f10a24761b25
> > --- /dev/null
> > +++ b/drivers/resctrl/cbqri_resctrl.c
> 
> ...
> 
> > +void resctrl_arch_reset_all_ctrls(struct rdt_resource *r)
> > +{
> > +	u32 num_closid = resctrl_arch_get_num_closid(r);
> > +	struct rdt_ctrl_domain *d;
> > +	enum resctrl_conf_type t;
> > +	u32 default_ctrl;
> > +	u32 i;
> > +
> > +	lockdep_assert_cpus_held();
> > +
> > +	if (!num_closid)
> > +		return;
> > +
> > +	default_ctrl = resctrl_get_default_ctrl(r);
> > +
> > +	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
> > +		for (i = 0; i < num_closid; i++) {
> > +			for (t = 0; t < CDP_NUM_TYPES; t++) {
> > +				int rerr;
> > +
> > +				rerr = resctrl_arch_update_one(r, d, i, t, default_ctrl);
> > +				if (rerr)
> > +					pr_err_ratelimited("rid=%d reset RCID %u type %u failed (%d)\n",
> > +							   r->rid, i, t, rerr);
> > +			}
> > +		}
> 
> 
> Above looks to be an open-code of cbqri_init_domain_ctrlval(). The loop
> is unexpected here due to the duplicate writes impacting types not used by current
> CDP mode that the comment within cbqri_init_domain_ctrlval() justifies.

Thanks for pointing this out. I'll simplify it by calling
cbqri_init_domain_ctrlval() for each domain.

> 
> > +	}
> > +}
> > +
> 
> ...
> 
> > +
> > +static int cbqri_init_domain_ctrlval(struct rdt_resource *r, struct rdt_ctrl_domain *d)
> > +{
> > +	u32 num_closid = resctrl_arch_get_num_closid(r);
> > +	enum resctrl_conf_type t;
> > +	int err = 0;
> > +	u32 i;
> > +
> > +	for (i = 0; i < num_closid; i++) {
> > +		/*
> > +		 * Seed both DATA and CODE staged slots so a later mount
> 
> nit: This seems to refer to d->staged_config[] that is only populated by resctrl fs.

I'll change the wording to refer to the hardware configuration for each
type and not the staged config.

> 
> > +		 * with -o cdp does not see stale CODE values.
> > +		 * On non-AT controllers cbqri_cc_alloc_op() masks AT to 0
> > +		 * so all three iterations land on the same hardware state.
> > +		 * The redundant writes are harmless.
> > +		 */
> > +		for (t = 0; t < CDP_NUM_TYPES; t++) {
> > +			err = resctrl_arch_update_one(r, d, i, t,
> > +						      resctrl_get_default_ctrl(r));
> > +			if (err)
> > +				return err;
> > +		}
> > +	}
> > +	return 0;
> > +}
> > +
> 
> ...
> 
> > +/*
> > + * Attach a CPU to the picked capacity controller at each cache level whose
> > + * cache the CPU shares. On failure, detach the CPU from everything attached
> > + * so far: the cpuhp core does not run this state's offline teardown when
> > + * its startup fails, so a partial attach would otherwise leak into the
> > + * domain cpu_masks. Caller holds cbqri_domain_list_lock.
> > + */
> > +static int cbqri_attach_cpu_to_all_ctrls(unsigned int cpu)
> > +{
> > +	static const u32 levels[] = { 2, 3 };
> > +	struct cbqri_resctrl_res *hw_res;
> > +	struct cbqri_controller *ctrl;
> > +	struct rdt_ctrl_domain *d;
> > +	struct list_head *pos;
> > +	struct cacheinfo *ci;
> > +	int i, rid;
> > +
> > +	lockdep_assert_held(&cbqri_domain_list_lock);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(levels); i++) {
> > +		ci = get_cpu_cacheinfo_level(cpu, levels[i]);
> > +		if (!ci)
> > +			continue;
> > +
> > +		rid = cbqri_cache_level_to_rid(levels[i]);
> > +		hw_res = &cbqri_resctrl_resources[rid];
> > +		if (!hw_res->nr_ctrls)
> > +			continue;
> > +
> > +		ctrl = cbqri_resctrl_find_ctrl(hw_res, ci->id);
> > +		if (!ctrl) {
> > +			pr_warn_once("no L%u controller for cache id %u, CPU %u is not controlled at this level\n",
> > +				     levels[i], ci->id, cpu);
> > +			continue;
> > +		}
> > +
> > +		d = cbqri_find_ctrl_domain(&hw_res->resctrl_res.ctrl_domains,
> > +					   ci->id, &pos);
> > +		if (d) {
> > +			cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
> > +			continue;
> > +		}
> > +
> > +		d = cbqri_create_ctrl_domain(ctrl, &hw_res->resctrl_res, cpu,
> > +					     ci->id, pos);
> > +		if (IS_ERR(d)) {
> > +			cbqri_detach_cpu_from_all_ctrls(cpu);
> > +			return PTR_ERR(d);
> > +		}
> 
> Should a failure to set up one domain prevent the CPU from coming online?
> 
> As I understand the driver already brings a CPU online without a domain (albeit
> with a pr_warn_once()) at a level when its cache has no controller (the earlier
> cbqri_resctrl_find_ctrl()), so I wonder if here (on domain creation failure) the
> CPU could just be left without a domain at this level without failing the CPU
> online entirely? It looks like cbqri_detach_cpu_from_all_ctrls() keeps the domains
> consistent.

Good question. It does seem like an additional cpu would be beneficial
to a system, even if the qos functionality is not working as expected.
I will change the driver to warn but not fail the cpu online.

> 
> In the end this is a driver design question, so up to you.
> 
> I just have a few nits and a check-in on the design but all the resctrl filesystem 
> interactions look good to me.
> 
> The one open is the coordination with Tony's series that moves the
> resctrl_arch_alloc_capable() and resctrl_arch_mon_capable() work into
> resctrl filesystem. Thanks for making the switch to use alloc_capable, that will
> simplify the accompanying RISC-V changes.

I'll remove the hooks if Tony's series lands first.

> Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Thanks for your attention on this series!

Drew
