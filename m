Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B845E2528EA
	for <linux-rt-devel@lists.linux.dev>; Mon, 10 Feb 2025 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739197413; cv=none; b=fydAX0srZoxVOAci0rXfaTf2A685tlbE/88FsVOX1fJnobPTlG6LysHrEvp0NS/U/ijJsaHNSVWQ3WHk3SuRz+j/u9JGivq1/bmm8zcj5tnsjptFitvK0ianJx0nb1bFjQQNZ0+W+Ft2rbQKgAwErzn+hiX3K5EXrVyeIUB0GFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739197413; c=relaxed/simple;
	bh=FDKA7JM0WWX/iStFmB8HmoIikA4WkwllGlcdD0D6T7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPj3tVeIDPIO/ZFoHdkD2PjqzbtaZRxKSmCTHR6bnQ+fK8fVRGZ1Z1fXoCpdI4OKJfz7OZxTigB5IIvxen97wqphTywNSR8CszNgqRCNgQfY6dyUsgwmayoGKbtFAa1GhrO9HfKs+A4qrw/h9wZMFn4vseYlfg1jn0qeW8GhYKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UXwpM+UG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y31wsz+8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UXwpM+UG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y31wsz+8"
Date: Mon, 10 Feb 2025 15:23:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739197409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9ihDNYI+zCbf0NSoNI9c/FdnZzk61DWASBxjVSt6UM=;
	b=UXwpM+UGp5qjzqj1voR9MR6/yauR9Llt5V2fxsn/AkztJ7hHK4f3VMqPXIU/l8/1rq77yd
	wOCKfd3fwE6jSZvxZyPJK0jvxUHyThQED6Sp9GHawBtU/AcYI+QaGXMjjZ8qy3KKKYcqEW
	ZknWvJkTegstEEYOYYSlrh2JsguBBfdc0vC+wwF457yqYn+EfgZCW58ZYemyQrhFRXabxV
	8Xxg3WhICEJi+gQaMmCakoUzTrWDUtnaxcXHYOAEvzAg8AcXlV5hVj4gN3FUVFwVRAjSX1
	hTzC5cDetCLWBmgm8+EtGQsp2KjtUUlyO05Mi4Km/r9zb9GHkQuIvFfnaOcyTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739197409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9ihDNYI+zCbf0NSoNI9c/FdnZzk61DWASBxjVSt6UM=;
	b=Y31wsz+8FgMeY5YVZLiMPgwoBy7PbtqoeifYuoiMjBYb+lLwumRrX2ocY65RNcp34aZTjU
	R304GRy80KbeWkBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 5/9] powerpc: Use preempt_model_str().
Message-ID: <20250210142327.bCujH28L@linutronix.de>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
 <20250203141632.440554-6-bigeasy@linutronix.de>
 <65c6f60d-bb52-48bd-a02c-87ffd2a915d4@csgroup.eu>
 <20250203160103.9DikC9FJ@linutronix.de>
 <51999b8e-61c0-48b7-b744-c83d39e7f311@csgroup.eu>
 <20250204082223.6iNyq_KR@linutronix.de>
 <7b51f7de-8e4b-4766-85ca-dee24832c693@linux.ibm.com>
 <20250210105949.b9PKqiw7@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250210105949.b9PKqiw7@linutronix.de>

On 2025-02-10 11:59:50 [+0100], To Shrikanth Hegde wrote:
> Thank you for noticing. I did remove it on other architectures, I
> somehow missed it here. Will remove it from from the arch code.

This is what I have for powerpc now. I'm going to repost the series,
currently waiting for arm/x86.

-------->8-----------

Subject: [PATCH] powerpc: Rely on generic printing of preemption model.

After the first printk in __die() there is show_regs() ->
show_regs_print_info() which prints the current
preemption model.

Remove the preempion model from the arch code.

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/kernel/traps.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index edf5cabe5dfdb..cb8e9357383e9 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -263,10 +263,9 @@ static int __die(const char *str, struct pt_regs *regs, long err)
 {
 	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
 
-	printk("%s PAGE_SIZE=%luK%s%s%s%s%s%s %s\n",
+	printk("%s PAGE_SIZE=%luK%s %s%s%s%s %s\n",
 	       IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN) ? "LE" : "BE",
 	       PAGE_SIZE / 1024, get_mmu_str(),
-	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "",
 	       IS_ENABLED(CONFIG_SMP) ? " SMP" : "",
 	       IS_ENABLED(CONFIG_SMP) ? (" NR_CPUS=" __stringify(NR_CPUS)) : "",
 	       debug_pagealloc_enabled() ? " DEBUG_PAGEALLOC" : "",
-- 
2.47.2

