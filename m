Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1872063CB
	for <linux-rt-devel@lists.linux.dev>; Tue,  4 Feb 2025 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738657348; cv=none; b=jHk529ipEK6oVDLTl/nKvJIJpx6L7VgpFOUO37aU/1uF35k4eDlETrae6MMtwFRZ0bwQh/gyztsZ+WeBfErkbptV7zRTQMRqH/nqIbilPkxpvqwKVNCKg+c0pWZLLdxlMr6dkvbtfhN7b85BuXVF/uuvIoVduGBevyKcNeu6+Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738657348; c=relaxed/simple;
	bh=+pDnJIsZzMoJu/KlX0witVz381rBhqyriIHKc03SRi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFO3Sk/sUgEbdSlbOvsY6qzqKv64KdrbRncfnk9T/KTcNZY8ula/eJ94rmGotT5O9jerkmx5vpvtQsQNb4LWd2tH4dEpHbdDV1Uu1D4Xmlajno01PW6e0Q5NdTlmR7dou5c/QwcSXAc5dQtEmAHDE/rMUuDwKxP1JbNSs9vot5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Flufws2T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9bVplinw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Flufws2T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9bVplinw"
Date: Tue, 4 Feb 2025 09:22:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738657345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DnKDCU1FUD2pmjVQdxzJZnfkfi9EpwFgK55JyMARIzA=;
	b=Flufws2Tc9X0nPhdWeTbARtFtpmLKyJhRjTdAqJ6fPfEhNQTEABuzNj2b9h/wqxgpygsJQ
	BvQ9McEJAT79GteclYmajpufEIKfY1l+WTmpF6XBquIURUICO84ga34gXaSr0Zkw3PhTOW
	4GPHQCDySVG9PXZ8kZSoJyzwXGy5oLvEW0ZcyQysrrpKuZVddyvoUndbakAOx47HtGtexn
	ukV+CKsl+dm88D3aMK6Vlbqi8PZB0kpT7qo0jQ2zW4SjSkmiB6Dy+KkMUTqBlPFOJuw7KZ
	Fi6/V1EPJ5cM8naXbIr5Ajs2/HOm23m3YllPtnqCmiVmfc78hgnKQhQrnf/W/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738657345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DnKDCU1FUD2pmjVQdxzJZnfkfi9EpwFgK55JyMARIzA=;
	b=9bVplinw5uTckiBFUaa4zx9QSnLzFLQniSAa/sUY9kv2nk/w7pKzIIqBRVZtU6jJb9dp9Q
	qw/sYFSz9uG4XPBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 5/9] powerpc: Use preempt_model_str().
Message-ID: <20250204082223.6iNyq_KR@linutronix.de>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
 <20250203141632.440554-6-bigeasy@linutronix.de>
 <65c6f60d-bb52-48bd-a02c-87ffd2a915d4@csgroup.eu>
 <20250203160103.9DikC9FJ@linutronix.de>
 <51999b8e-61c0-48b7-b744-c83d39e7f311@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <51999b8e-61c0-48b7-b744-c83d39e7f311@csgroup.eu>

Use preempt_model_str() instead of manually conducting the preemption
model. Use pr_emerg() instead of printk() to pass a loglevel.

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v2=E2=80=A6v3:
  - Use printk() instead of pr_emerg() to remain consistent with the
    other invocations in terms of printing context.

 arch/powerpc/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index edf5cabe5dfdb..d6d77d92b3358 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -263,10 +263,10 @@ static int __die(const char *str, struct pt_regs *reg=
s, long err)
 {
 	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
=20
-	printk("%s PAGE_SIZE=3D%luK%s%s%s%s%s%s %s\n",
+	printk("%s PAGE_SIZE=3D%luK%s %s %s%s%s%s %s\n",
 	       IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN) ? "LE" : "BE",
 	       PAGE_SIZE / 1024, get_mmu_str(),
-	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "",
+	       preempt_model_str(),
 	       IS_ENABLED(CONFIG_SMP) ? " SMP" : "",
 	       IS_ENABLED(CONFIG_SMP) ? (" NR_CPUS=3D" __stringify(NR_CPUS)) : "",
 	       debug_pagealloc_enabled() ? " DEBUG_PAGEALLOC" : "",
--=20
2.47.2

