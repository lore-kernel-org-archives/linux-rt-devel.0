Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C44F17C2
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 00:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739320555; cv=none; b=lQAXjNbQKdFIPW+6aGWHk7w6raJ4VJL8MIvv8zQBNAQY1vBEtdLUDu5jWj/VjwKL2nN9PY9oWr3F+7I0vxH6CDVzFZ0dTOoHQ+XwxT6OlDJMVwMrYhvsUbIklbSxTkuMe4dqbSaPYgUeSO1NFT+qNw6CbuDMzUrN9TjqB1eVzog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739320555; c=relaxed/simple;
	bh=UR4QfZTIJTrO2lXvEeYKL5U/o2nD8hI4xCOmxpv9iWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKr/LlhNJS7CPKnIP+Qs2p6HnteoU13n9DWi9NYcTp+Y5esRvfSHsguvypOad3mpOqTjjFG8tzZXd3F8vChhov7BFTyEud1KDg7n6jjy3HEh8CA0jKN0xle4rsJ7SlM1w/phTicTeUaiRG+1PP+khgqEFtKY71oI6W0Wg65FWOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KkVRP2MG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkVRP2MG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739320552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Ba53R3H3WDAF7MlUncdYdrTqagtlieEXBUgKa6/Q38=;
	b=KkVRP2MGTMzleT2MkrCx136tPLiSOU+BBcGSqx8b39u4M7xCT+7vi7JdVJL3rOmGG7HBAX
	E3ZhIGevTqxykI132KaXW+HwF5qkts1okj6btxrerzrxcWB/HA3QezmsyyCUgM5OyscEnH
	mlZemhhwJ18PjYeHauD+/zCwKjNq6eQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-3xrX5GqPMOq7aTI1VFcphA-1; Tue,
 11 Feb 2025 19:35:50 -0500
X-MC-Unique: 3xrX5GqPMOq7aTI1VFcphA-1
X-Mimecast-MFC-AGG-ID: 3xrX5GqPMOq7aTI1VFcphA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DD9A1954B1B;
	Wed, 12 Feb 2025 00:35:43 +0000 (UTC)
Received: from localhost (unknown [10.22.89.254])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CBB1C3001D10;
	Wed, 12 Feb 2025 00:35:41 +0000 (UTC)
Date: Tue, 11 Feb 2025 21:35:40 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: BUG: debug_exception_enter() disables preemption and may call
 sleeping functions on aarch64 with RT
Message-ID: <Z6vs3IWxUxhIDBBO@uudg.org>
References: <Z6YW_Kx4S2tmj2BP@uudg.org>
 <Z6n16cK85JMyowDq@J2N7QTR9R3>
 <Z6tf8iDhNriSGjeC@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6tf8iDhNriSGjeC@uudg.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Feb 11, 2025 at 11:34:26AM -0300, Luis Claudio R. Goncalves wrote:
> On Mon, Feb 10, 2025 at 12:49:45PM +0000, Mark Rutland wrote:
> > On Fri, Feb 07, 2025 at 11:22:57AM -0300, Luis Claudio R. Goncalves wrote:
...
> > I don't have an immediate suggestion; I'll need to go think about this
> > for a bit. Unfortunatealy, there are several nested cans of worms here.
> > :/
> > 
> > In theory, we can go split out the EL0 "debug exceptions" into separate
> > handlers, and wouldn't generally need to disable preemption for things
> > like BRK or single-step.
> 
> If this is an acceptable workaround, until we have the real solution,
> I can work on that :)
> 
> Luis

I tested the prototype below and it survived 6h of ssdd and the ptrace LTP
tests running simultaneously, in a tight loop. Would something along these
lines be an acceptable workaround?


diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 8b281cf308b30..eb3b54710024f 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -933,18 +933,20 @@ void __init hook_debug_fault_code(int nr,
  * accidentally schedule in exception context and it will force a warning
  * if we somehow manage to schedule by accident.
  */
-static void debug_exception_enter(struct pt_regs *regs)
+static void debug_exception_enter(struct pt_regs *regs, int touch_preemption)
 {
-	preempt_disable();
+	if (touch_preemption)
+		preempt_disable();
 
 	/* This code is a bit fragile.  Test it. */
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "exception_enter didn't work");
 }
 NOKPROBE_SYMBOL(debug_exception_enter);
 
-static void debug_exception_exit(struct pt_regs *regs)
+static void debug_exception_exit(struct pt_regs *regs, int touch_preemption)
 {
-	preempt_enable_no_resched();
+	if (touch_preemption)
+		preempt_enable_no_resched();
 }
 NOKPROBE_SYMBOL(debug_exception_exit);
 
@@ -953,8 +955,14 @@ void do_debug_exception(unsigned long addr_if_watchpoint, unsigned long esr,
 {
 	const struct fault_info *inf = esr_to_debug_fault_info(esr);
 	unsigned long pc = instruction_pointer(regs);
+	unsigned long req = ESR_ELx_EC(esr);
+	int touch_preemption;
 
-	debug_exception_enter(regs);
+	touch_preemption = !(IS_ENABLED(CONFIG_PREEMPT_RT) &&
+		(req == ESR_ELx_EC_SOFTSTP_LOW || req == ESR_ELx_EC_BRK64
+		 || req == ESR_ELx_EC_BKPT32 || req == ESR_ELx_EC_SOFTSTP_CUR));
+
+	debug_exception_enter(regs, touch_preemption);
 
 	if (user_mode(regs) && !is_ttbr0_addr(pc))
 		arm64_apply_bp_hardening();
@@ -963,7 +971,7 @@ void do_debug_exception(unsigned long addr_if_watchpoint, unsigned long esr,
 		arm64_notify_die(inf->name, regs, inf->sig, inf->code, pc, esr);
 	}
 
-	debug_exception_exit(regs);
+	debug_exception_exit(regs, touch_preemption);
 }
 NOKPROBE_SYMBOL(do_debug_exception);
 

