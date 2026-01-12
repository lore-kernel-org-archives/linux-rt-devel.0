Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E1E335BA8
	for <linux-rt-devel@lists.linux.dev>; Mon, 12 Jan 2026 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768226921; cv=none; b=bTsGzbfKZeECrNTsCyecHwDqWWx6wjK0sSaqbXaFO4pwy7Vax1f3Xso7lSU6pljr2sgRGk/4f+xvmf8H6qorvjUqrcZtNCPbpEHw+spUBRtuA+zTvLpvUCJK5LyFk/wrp5IxbkTyhd/pCfouOyZYIj8cShHzJPadGc3vSUcW9mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768226921; c=relaxed/simple;
	bh=ULDL+SYSOCLDESByzA1BhJPUxvFUj3L4U0Tc+p+RYrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjPtfr8c82+hayNcWh0ipUCQ60O+yW+M1YVltSoM8HVudXHHAy/KBmavnDpTVdTkN04W8zCYYVcCOIxVwzvN2sxLu42ZTA+nMaOK8HeEehwjF5GBVAPC862TjwjvaWT5FrPlxZpmMLXziflE3kFdljpuocPmCSQAOcXkHcCThB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EL7IjEAQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/B0UsT/B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EL7IjEAQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/B0UsT/B"
Date: Mon, 12 Jan 2026 15:08:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768226918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EEtMmgPNhmFaINe9TnjsfyUKoDihi7X8JmYghahaSFU=;
	b=EL7IjEAQL3SnBdHEXZ161o6oRQFDktiZDyNkUrKcIKlyDu5GwM9SQLqkWYOECzR+VG3MnB
	EoGtkmESbzAS+CHzneoJO1KlR2556+FQ8rbFGUHLEngSiaYW3BCUpKS6M9tqVq4vfxaxmF
	3clyfKOzonX26sdu65/37e6HRjq2KMN7EX5tMZkjQiGJzh9/Wl/GqQh2Cr8Ox1FbMNFtho
	MjrIw/uOy14ucVKURdAjMgKmPKvJPGgtF8XflgCCAq6Yl1CaebqxHXocjsyiMrIit4Fle8
	Az8NOaDz47CTgd+Fppqas0L/BHM55FWMVefF222dBdEJsCnSgAgDMC70luILFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768226918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EEtMmgPNhmFaINe9TnjsfyUKoDihi7X8JmYghahaSFU=;
	b=/B0UsT/BcB8QPv+DLxXgzn7yvdimvI4jTGw3fJ+4ZXYdsQ2T1IBeg4FExn2gbiupPIntpB
	/L2vFySG5YjiGPAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Marc Zyngier <maz@kernel.org>
Cc: Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't acquire rt_spin_lock in
 allocate_vpe_l1_table()
Message-ID: <20260112140837.UNQYT563@linutronix.de>
References: <20260107215353.75612-1-longman@redhat.com>
 <864iowmrx6.wl-maz@kernel.org>
 <87ms2nsqju.ffs@tglx>
 <86wm1qlq7l.wl-maz@kernel.org>
 <87ecnwij44.ffs@tglx>
 <86v7h8l9ht.wl-maz@kernel.org>
 <87pl7gglya.ffs@tglx>
 <86tswrkrh4.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <86tswrkrh4.wl-maz@kernel.org>

On 2026-01-12 11:20:07 [+0000], Marc Zyngier wrote:
> On Sun, 11 Jan 2026 16:20:45 +0000,
> Thomas Gleixner <tglx@kernel.org> wrote:
> >=20
> > On Sun, Jan 11 2026 at 10:38, Marc Zyngier wrote:
> > > On Sun, 11 Jan 2026 09:39:07 +0000,
> > > Thomas Gleixner <tglx@kernel.org> wrote:
> > >>=20
> > >> On Fri, Jan 09 2026 at 16:13, Marc Zyngier wrote:
> > >> > On Thu, 08 Jan 2026 22:11:33 +0000,
> > >> > Thomas Gleixner <tglx@kernel.org> wrote:
> > >> >> At the point where a CPU is brought up, the topology should be kn=
own
> > >> >> already, which means this can be allocated on the control CPU _be=
fore_
> > >> >> the new CPU comes up, no?
> > >> >
> > >> > No. Each CPU finds *itself* in the forest of redistributors, and f=
rom
> > >> > there tries to find whether it has some shared resource with a CPU
> > >> > that has booted before it. That's because firmware is absolutely a=
wful
> > >> > and can't present a consistent view of the system.
> > >>=20
> > >> Groan....
> > >>
> > >> > Anyway, I expect it could be solved by moving this part of the ini=
t to
> > >> > an ONLINE HP callback.
> > >>=20
> > >> Which needs to be before CPUHP_AP_IRQ_AFFINITY_ONLINE, but even that
> > >> might be to late because there are callbacks in the STARTING section,
> > >> i.e. timer, perf, which might rely on interrupts being accessible.
> > >
> > > Nah. This stuff is only for direct injection of vLPIs into guests, so
> > > as long as this is done before we can schedule a vcpu on this physical
> > > CPU, we're good. No physical interrupt is concerned with this code.
> >=20
> > That's fine then. vCPUs are considered "user-space" tasks and can't be
> > scheduled before CPUHP_AP_ACTIVE sets the CPU active for the scheduler.
>=20
> Waiman, can you please give the following hack a go on your box? The
> machines I have are thankfully limited to a single ITS group, so I
> can't directly reproduce your issue.
>=20
> Thanks,
>=20
> 	M.
>=20
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v=
3-its.c
> index ada585bfa4517..20967000f2348 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -2896,7 +2896,7 @@ static bool allocate_vpe_l2_table(int cpu, u32 id)
>  	return true;
>  }
> =20
> -static int allocate_vpe_l1_table(void)
> +static int allocate_vpe_l1_table(unsigned int cpu)
>  {
>  	void __iomem *vlpi_base =3D gic_data_rdist_vlpi_base();
>  	u64 val, gpsz, npg, pa;
> @@ -3012,10 +3012,11 @@ static int allocate_vpe_l1_table(void)
> =20
>  out:
>  	gicr_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
> -	cpumask_set_cpu(smp_processor_id(), gic_data_rdist()->vpe_table_mask);
> +	cpumask_set_cpu(cpu, gic_data_rdist()->vpe_table_mask);
> +	dsb(sy);
> =20
>  	pr_debug("CPU%d: VPROPBASER =3D %llx %*pbl\n",
> -		 smp_processor_id(), val,
> +		 cpu, val,
>  		 cpumask_pr_args(gic_data_rdist()->vpe_table_mask));
> =20
>  	return 0;
> @@ -3264,15 +3265,9 @@ static void its_cpu_init_lpis(void)
>  		val =3D its_clear_vpend_valid(vlpi_base, 0, 0);
>  	}
> =20
> -	if (allocate_vpe_l1_table()) {
> -		/*
> -		 * If the allocation has failed, we're in massive trouble.
> -		 * Disable direct injection, and pray that no VM was
> -		 * already running...
> -		 */
> -		gic_rdists->has_rvpeid =3D false;
> -		gic_rdists->has_vlpis =3D false;
> -	}
> +	if (smp_processor_id() =3D=3D 0)
> +		cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "irqchip/arm/gicv3:vpe",
> +				  allocate_vpe_l1_table, NULL);

If you move it the online state then you could also
s/GFP_ATOMIC/GFP_KERNEL.

Also previously you checked the error code set has_rvpeid, has_vlpis on
failure. Now you you should the same in case of a failure during
registration.
This also happens happens on CPU hotplug and I don't see how you avoid a
second allocation. But I also don't understand why this registrations
happens on CPU0. It might be just a test patch=E2=80=A6

> =20
>  	/* Make sure the GIC has seen the above */
>  	dsb(sy);

Sebastian
