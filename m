Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCB737DEBE;
	Sat, 27 Jun 2026 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782595322; cv=none; b=H8O42TNMe/dxLUlEbamrQs4mYYUjwQKgnc7lh44wuaBjkTAlJxjqY/Vg5ibnWj9lMC0j53DIUXQrFOZrQOPVJcCgHJMeup1v0JkX2tbSBEqgO0xscApr1taGqGRC+pevc0PS6jq7Vo1oj5+mmRE/ZOEqK5XcH2AibUMdd6KqO5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782595322; c=relaxed/simple;
	bh=Fi1sJsXvDdbr5TiNG1ZQ0mwkB/0WBJXhm5w8HcQsOfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYPpdDxpecR3W2amPq3TdTarpKhruyUxKpoSnAWisLcs9Z5hi2W99CrOPbJ+1+QP1PKL5ymsqh/OxTe0nrU1nhnEzIgwj8Smo/jI+oQeLNe4bGwWea4Pv3w3R7ZVcI1XT99MnpOA+dSQANRWxCi0u6z2Re4wGQgz4MwhHjGshFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTcZyUvM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTcZyUvM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C3C1F000E9;
	Sat, 27 Jun 2026 21:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782595320;
	bh=Bcf86Hzsw/x7zxg/mG4FuMFcMosZF81My9ebts7C9Hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CTcZyUvM1WqqdEtdr8HrkviG3NtbpPcdxP47O3QVTacavefegL7LP8NkHspwoFLfL
	 T8a4v2JX7sIJn4HOPhOZASVjttgmPzFsahuUoF86QaYBWsEk1sSo4fJ/SG2dIpYd6p
	 +pz2SmAI2INhq96GbGD7lJUah2mxAVBEZpSAYNPMOJ7fb8Q2SeeA4xf1H3vypuYk1Z
	 SYBbVPQQ1IfbyMoUo6X+QmblfYx8X9AVqsFVZLUGlajPhmRbxFSE62cfdMcdKMxNeF
	 /tK6duY4N5hrKCjUZlBDr6Y7cameZE9PSYnvNwn48iqGWSxxARkVHsqqsfOWARFZd2
	 bB3qj15cXuR3Q==
Date: Sat, 27 Jun 2026 14:21:59 -0700
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
	Dave Martin <Dave.Martin@arm.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
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
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	x86@kernel.org, devicetree@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org
Subject: Re: [External] [PATCH v2 3/8] riscv: Add support for srmcfg CSR from
 Ssqosid extension
Message-ID: <akA+95cvpOPc2XOG@x1>
References: <20260624-dfustini-atl-sc-cbqri-dt-v2-0-2f8049fd902b@kernel.org>
 <20260624-dfustini-atl-sc-cbqri-dt-v2-3-2f8049fd902b@kernel.org>
 <CAEEQ3w=ZLnW-Wz_=PcUQTN8q0wxUq1_epCs0B+v=sSug+OHD=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3w=ZLnW-Wz_=PcUQTN8q0wxUq1_epCs0B+v=sSug+OHD=Q@mail.gmail.com>

On Sat, Jun 27, 2026 at 05:11:11PM +0800, yunhui cui wrote:
> Hi Drew,

Hi, thanks for the reviews.

> 
> On Thu, Jun 25, 2026 at 9:40 AM Drew Fustini <fustini@kernel.org> wrote:
> >
> > Add support for the srmcfg CSR defined in the Ssqosid ISA extension.
> > The CSR contains two fields:
> >
> >   - Resource Control ID (RCID) for resource allocation
> >   - Monitoring Counter ID (MCID) for tracking resource usage
> >
> > Requests from a hart to shared resources are tagged with these IDs,
> > allowing resource usage to be associated with the running task.
> >
> > Add a srmcfg field to thread_struct with the same format as the CSR so
> > the scheduler can set the RCID and MCID for each task on context
> > switch. A per-cpu cpu_srmcfg variable mirrors the CSR state to avoid
> > redundant writes. L1D-hot memory access is faster than a CSR read and
> > avoids traps under virtualization.
> >
> > A per-cpu cpu_srmcfg_default holds the default srmcfg for each CPU as
> > set by resctrl CPU group assignment. On context switch, RCID and MCID
> > inherit from the CPU default independently: a task whose thread RCID
> > field is zero takes the CPU default's RCID, and likewise for MCID.
> >
> > Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
> > Assisted-by: Claude:claude-opus-4-7
> > Co-developed-by: Kornel Dulęba <mindal@semihalf.com>
> > Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
[..]
> > diff --git a/arch/riscv/include/asm/qos.h b/arch/riscv/include/asm/qos.h
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..e9e1d69f3797be5f89785a9b3aa7d9d51c476a8a
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/qos.h
[..]
> > +static inline void __switch_to_srmcfg(struct task_struct *next)
> > +{
[..]
> > +       if (thread_srmcfg != __this_cpu_read(cpu_srmcfg)) {
> > +               /*
> > +                * Drain stores from the outgoing task before the CSR write
> > +                * so they retain the previous RCID/MCID tag at the cache
> > +                * interconnect.
> > +                */
> > +               RISCV_FENCE(rw, o);
> > +
> > +               __this_cpu_write(cpu_srmcfg, thread_srmcfg);
> > +               csr_write(CSR_SRMCFG, thread_srmcfg);
> > +               /*
> > +                * Order the csrw before the new task's loads/stores so they
> > +                * pick up the new tag. Zicsr 6.1.1 makes CSR writes weakly
> > +                * ordered (device-output) vs memory ops. Ssqosid v1.0 is
> > +                * silent so honor the general CSR rule.
> > +                */
> > +               RISCV_FENCE(o, rw);
> 
> This is in the context-switch path and may be expensive in practice. Even if
> the target workload is pinned and grouped, unpinned/default-group tasks or
> kworkers may still run on those CPUs, causing frequent SRMCFG transitions and
> paying two fences each time.
> 
> Is this strict ordering required by the Ssqosid spec or known hardware? If
> not, can we make this a trade-off and avoid the fences by default, accepting a
> small QoS-tagging inaccuracy around the context-switch boundary?

These fences were introduced based on Sashiko feedback on the RFC
series. You make a good point that this may be too conservative and some
inaccuracy probably would be acceptable. I would be okay with dropping
them, and we can reevaluate once more hardware implementations with
Ssqosid become public.

Thanks,
Drew
