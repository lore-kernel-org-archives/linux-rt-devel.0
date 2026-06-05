Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9212EC0A4
	for <linux-rt-devel@lists.linux.dev>; Fri,  5 Jun 2026 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680433; cv=none; b=o/H3VxFsS2csgljxsJTo/buBnS4LMQI2UYGPi5pZgT8pTrxEg0u6yQFNFBxlWe77k8cPbR8yg28aumS15Od93h4sXZCgvujOQG8MWY6jSiZTr2lbI349VLvlBSNsR+oynDkwmpCK5SWAUZqnIO9Xhsa1eBXnupPSTEpMH6S/aN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680433; c=relaxed/simple;
	bh=puyYkxbUqmwYn1D+z/2yjwH5aLoZeHUM4d342S4Qc1c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P8pfSMShdvSkoM+M0Kwy4ERff5oS1XT1MNxBziYCpeYEPL1o0gqAovpgXPmwSezulLnQycleE2hLzXaeAx30aYunpc3lMK3ef0rzpmudKtcQrLvriGRVx6CsS8XfKGZJouM5Yus6umbcuX+4BPyZaglhXwerNBCHcPfv+bpzEXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Ios0mw96; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Ios0mw96"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1780680425;
	bh=y2PRG9+UXB8P/bXeCP8UwBiN5t2FEk6r0MqpdXeuOVs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Ios0mw96gcMBsJV5nmAZOuPjK+zZ/6vJ88EvH5Cmil0ta3YiXbQvW6mq2QaRYZSqv
	 x5TwzUkS8McuZX0NEUBG30m6A55n9bgMLEwtDzX0PhFZu3PHWLAy4cSTEL/QxV4mZq
	 /XOmALlYrJAaTjpdDemdavGJAqcmTVlQLzofoaqw=
Received: from [IPv6:2408:824e:307:6541:546a:40ae:5851:c0ef] (unknown [IPv6:2408:824e:307:6541:546a:40ae:5851:c0ef])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 4E19965982;
	Fri,  5 Jun 2026 13:27:00 -0400 (EDT)
Message-ID: <6be1cdd5f91dd7418a32ff372a6f3ae259b19195.camel@xry111.site>
Subject: Re: [PATCH v2] irq_work: Fix use-after-free in irq_work_single on
 PREEMPT_RT
From: Xi Ruoyao <xry111@xry111.site>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev, 
 Steven Rostedt <rostedt@goodmis.org>, Clark Williams
 <clrkwllms@kernel.org>, "Peter Zijlstra (Intel)"	 <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Mingcong Bai	 <jeffbai@aosc.io>, Henry Chen
 <chenx97@aosc.io>, Huacai Chen	 <chenhuacai@kernel.org>, Yao Zi
 <ziyao@disroot.org>
Date: Sat, 06 Jun 2026 01:26:55 +0800
In-Reply-To: <20260605104530.LDbF5MDD@linutronix.de>
References: <20260330073234.303732-1-jiayuan.chen@linux.dev>
	 <20260402065015.JKszGSXu@linutronix.de>
	 <52db48708d5a7fbcd146745c4288e567424c909a.camel@xry111.site>
	 <20260605104530.LDbF5MDD@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2026-06-05 at 12:45 +0200, Sebastian Andrzej Siewior wrote:
> On 2026-06-05 18:31:41 [+0800], Xi Ruoyao wrote:
> > Hi,
> >=20
> > This commit significantly slows down execve() (and perhaps other things=
)
> > on MIPS.=C2=A0 A very simple program:
>=20
> This is probably originating from sched_mm_cid_exit(). Can you check?

I've not checked that yet (I have to admit I don't really know how).

On the other hand, Yao Zi told me she speculated this might be related
to the lack of arch_irq_work_raise on MIPS.  For mips/loongson64 the IPI
support is already there and we only need 16 lines to implement
arch_irq_work_raise:

diff --git a/arch/mips/include/asm/irq_work.h b/arch/mips/include/asm/irq_w=
ork.h
new file mode 100644
index 000000000000..2695e0f94f2f
--- /dev/null
+++ b/arch/mips/include/asm/irq_work.h
@@ -0,0 +1,4 @@
+static inline bool arch_irq_work_has_interrupt(void)
+{
+	return IS_ENABLED(CONFIG_MACH_LOONGSON64) && IS_ENABLED(CONFIG_SMP);
+}
diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 2427d76f953f..30a036e5bfc4 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -50,6 +50,8 @@ extern int __cpu_logical_map[NR_CPUS];
 #define SMP_CALL_FUNCTION	0x2
 /* Octeon - Tell another core to flush its icache */
 #define SMP_ICACHE_FLUSH	0x4
+/* Loongson 3 - IRQ work */
+#define SMP_IRQ_WORK 0x8
=20
 /* Mask of CPUs which are currently definitely operating coherently */
 extern cpumask_t cpu_coherent_mask;
diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
index 147acd972a07..e584299d0fde 100644
--- a/arch/mips/loongson64/smp.c
+++ b/arch/mips/loongson64/smp.c
@@ -381,6 +381,13 @@ loongson3_send_ipi_mask(const struct cpumask *mask, un=
signed int action)
 		ipi_write_action(cpu_logical_map(i), (u32)action);
 }
=20
+#ifdef CONFIG_IRQ_WORK
+void arch_irq_work_raise(void)
+{
+	loongson3_send_ipi_single(smp_processor_id(), SMP_IRQ_WORK);
+}
+#endif
+
 static irqreturn_t loongson3_ipi_interrupt(int irq, void *dev_id)
 {
 	int cpu =3D smp_processor_id();
@@ -397,6 +404,9 @@ static irqreturn_t loongson3_ipi_interrupt(int irq, voi=
d *dev_id)
 		irq_exit();
 	}
=20
+	if (action & SMP_IRQ_WORK)
+		irq_work_run();
+
 	return IRQ_HANDLED;
 }

With this the performance indeed becomes normal.

--=20
Xi Ruoyao <xry111@xry111.site>
