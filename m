Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A212E29AAFA
	for <linux-rt-devel@lists.linux.dev>; Sat, 30 May 2026 00:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102279; cv=none; b=VeKhjhrUOyQVqpmZp7WWBIQcej4Eh7J2tiVwbvWOOk9oXmzLfR4as1EzSGzZfnS27Mx0c6IKxzYcUo7ZtNJJFQVr84SexGhXhLRDJSHPLyInAUEYiRIjCxYM4QOMbxWaqYBz/9aOVDVgukOSpVCKtST77jqJY/4hbEjBv68wq0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102279; c=relaxed/simple;
	bh=Rh/bzdbpeymFmSXBGT4/Yr53aWjDznmZW74qYHHz/hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=o2sFDCWeAEv8ni9M67NDr90baWgkV0TiLOuOGjQV12q0g9ZYA7eMLVtQE7EvGUW3euFWbSzTkRO3i1jkJU1DTyNov4cBIJxEqYdNrfyvVjAnfJ5jxrjLPyHKDENIOchJa70KYAJG9ipp0cmGyHDH883e8zNmLq2VuFvU1AuKXkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2F8UuQo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2F8UuQo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780102276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zRqQuSUnQXIp8UkHJ3sfDs0vFpquRuFQmXl1WKZBm+U=;
	b=S2F8UuQoOjJHvM99PdmER/XksgP8iotALc9uXXrO0g8MB837MFQBoY7pn2JZuZ3o44jq/0
	IJgCXZIVlsAETudLw/tlcgkXKGMC5VBpPsGenoS7WXUprCPKHM8/ECx/0DPdHHgYzC0xYi
	P+okaXYbBOpGLqmRnF7+AUm54aABlck=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-aSJK__TSM1uXw8sPVkz9hw-1; Fri,
 29 May 2026 20:51:13 -0400
X-MC-Unique: aSJK__TSM1uXw8sPVkz9hw-1
X-Mimecast-MFC-AGG-ID: aSJK__TSM1uXw8sPVkz9hw_1780102271
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C01F1956080;
	Sat, 30 May 2026 00:51:10 +0000 (UTC)
Received: from localhost (unknown [10.22.88.56])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 65F321800576;
	Sat, 30 May 2026 00:51:08 +0000 (UTC)
Date: Fri, 29 May 2026 21:51:06 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Waiman Long <longman@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] arm64/entry: Don't disable preemption in
 debug_exception_enter() with RT kernel
Message-ID: <aho0eqjMESuHxECr@redhat.com>
References: <20260519222524.886454-1-longman@redhat.com>
 <20260520061920.XCqBHe0x@linutronix.de>
 <a5251664-2c15-4a8e-906b-d204e10c38be@redhat.com>
 <20260528145124.v9o6OcOc@linutronix.de>
 <20260528153554.vllN7_T9@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260528153554.vllN7_T9@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 7gHa8YpRYEy5yZaVpr7bZFUkhE0Sd8efl0YPSQY60Gk_1780102271
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 28, 2026 at 05:35:54PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-05-28 16:51:24 [+0200], To Waiman Long wrote:
> > > The kernel backtrace is produced using the latest v7.1-rc4 kernel. There are
> > > a number of changes to the debug_exception_enter() and
> > > debug_exception_exit() functions over the years, but the preemption disable
> > > code remains since its introduction in v5.3.
> > 
> > Let me look at this again.
> 
> So how do you reproduce this? The calls within debug_exception_enter()/
> exit() look harmless or I miss the big thing here.
> From your backtrace, you have brk_handler() and this is gone since
> commit 31575e11ecf7e ("arm64: debug: split brk64 exception entry") which
> is v6.17-rc1. I can use gdb with breakpoint handling.

Sebastian, in the original series Ada provided a few tests, including the
two files I list below. Running that test in a v7.1-rc5 kernel with
PREEMPT_RT and DEBUG_ATOMIC_SLEEP enabled, I get this backtrace:

[10416.818417] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
[10416.818426] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 6437, name: gdb_prog1
[10416.818428] preempt_count: 1, expected: 0
[10416.818430] RCU nest depth: 1, expected: 1
[10416.818434] CPU: 11 UID: 0 PID: 6437 Comm: gdb_prog1 Not tainted 7.1.0-rc5-rt1 #2 PREEMPT_{RT,(full)} 
[10416.818437] Hardware name: Lenovo HR330A            7X33CTO1WW    /FALCON     , BIOS hve104r-1.15 02/26/2021
[10416.818440] Call trace:
[10416.818442]  show_stack+0x20/0x40 (C)
[10416.818450]  dump_stack_lvl+0x88/0xb8
[10416.818454]  dump_stack+0x18/0x30
[10416.818457]  __might_resched+0x18c/0x1c8
[10416.818462]  rt_spin_lock+0x4c/0x1b0
[10416.818467]  force_sig_info_to_task+0x34/0x1f0
[10416.818471]  force_sig_fault+0x68/0xb0
[10416.818473]  arm64_force_sig_fault+0x44/0x70
[10416.818476]  ptrace_hbptriggered+0xd0/0x150
[10416.818479]  __perf_event_overflow+0xf4/0x300
[10416.818483]  perf_swevent_event+0x1b8/0x1f0
[10416.818486]  perf_bp_event+0xcc/0xe0
[10416.818489]  do_breakpoint+0xf4/0x238
[10416.818493]  el0_breakpt+0x7c/0x200
[10416.818497]  el0t_64_sync_handler+0xa8/0xf0
[10416.818500]  el0t_64_sync+0x1b0/0x1b8


n order to run the test, you need to create two files with the names and
content listed below and run the following commands:

    cc gdb_prog1.c -o gdb_prog1 -O0 -g
    gdb -x gdb_cmdlist ./gdb_prog1

That's it.

The files I mentioned are:

===== gdb_cmdlist 

---------- >8 cut here 8< ----------
start
hbreak 3
watch target
commands 2
continue
end
commands 3
continue
end
continue
jump 11
continue
quit
---------- >8 cut here 8< ----------


===== gdb_prog1.c

---------- >8 cut here 8< ----------
int main() {
	int add = 0xAA;
	int target = 0;

	target += add;

#ifdef COMPAT
    __asm__("BKPT");
#else
    __asm__("BRK 1");
#endif

	return target;
}
---------- >8 cut here 8< ----------

Luis


