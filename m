Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AC218FDAF
	for <linux-rt-devel@lists.linux.dev>; Sat,  4 Oct 2025 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759566931; cv=none; b=oI2DDVnIgJR8q5/aXFsNfdGot5A86hyZOP/saqva5hkcWVfu9+Oh9uuE3QQo+Ke4lBUAhOgs/dNkCPQX9rVriBUwryoB7sHBstjrv8H/hm8EbladK8NK+ViRxfQkCaPkeKTDebn2OWfRz2OMS5aRupjL4cwXoINF4w7Knj/I9v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759566931; c=relaxed/simple;
	bh=PYQTbOzjjrSinDt1sSJeHCtccfb4Cv32VpWc589+4uc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EszY6yAnBsatXnSQTztRKAiSZksDckh3vLv0yCmfRxepqfWH8Owy32pqvhbqcQAx+9q145GQ7sifIgUoTx6C8INoGuBUj9yIVxiO4xfCEIgrdQWhOmRaVe3LbrzpS/zF7QPXyhJqDLfQwj4d0AYicn4wCaIs98NxleJIjx4CTp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dxzBHLTD; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dxzBHLTD"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-783604212ebso5865992b3a.3
        for <linux-rt-devel@lists.linux.dev>; Sat, 04 Oct 2025 01:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759566929; x=1760171729; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ch0JPZGJV+cgd4DAi8xMIAbXSmgRGeB0SwOcsNHqpyQ=;
        b=dxzBHLTDsHkCXGBrDcdRUpVYHaAbIsCOqaGHoOACV91h9kyhxIptk+9bU3jGfTxksN
         HiCMYqviZyLftk6F9TChsphWVa+nd43bH9sId+RBD9sDqWK9VJuNC67cZik+9haLgbdx
         t8V+C7Z7oHzTzPF+/LTgXC2yfZGA7DT8CHeoQyxNNp9pxoG0+F7sBhfOQNwkY6klpdcH
         XrchPXF0XE96ofUdHJFBikuJNqK9g7op5SM7XNEI8PdDL+MV91YAA4oK/xJMZXbrFsKv
         FFydqsyRmJLfPQLyhsXYHeTp4Djdu+4k1ZDgk3Cfw/1Kef4o6FQ9GLpUab+gAr+4k7Yc
         ZDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759566929; x=1760171729;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ch0JPZGJV+cgd4DAi8xMIAbXSmgRGeB0SwOcsNHqpyQ=;
        b=SHThxH2ZnxtzNw5nxC369oLwmZanUOfDFpBWr5is/csgCK1nQvvutE5QRGxSkkAQWU
         lqGwvgLGRxQyj30AiNr1t2pA5D07MpjbQjpKNiJZF0B8u83EmKsKv1PJPooGXkgd0uy0
         aSrtdppWKUAZczRin/cVG+R5vg2/07M3F4ecXraH9OJZCMoJ6z8KJnVbgMyQCU/gr+QP
         dFcBon+bBPbveddNCaBt/scMCpPcnDWVmn+cErSlPhZjH+/RnAT2URMt3ZsGp5/CVnlz
         z8itGw2r16GbvJ66nhNEn9Gue2fu4rT2JgXEUy0UQte+avd9iEigZwA4wPLKPYMHWifd
         NM0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKlF+q9nqPGVXHmMqjHt8A9NLMjmW9gqqCVhO4R6NpLXyKMDYFc+8Z50yNyhgWdLpxbClyJKiAHRIg3Lv9rg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw37Edseu+3PKRIocDer+ZGEyXfjdkUKgUCfP5Uu4tLDMTwPh9w
	lNyqGgolQkIUDNFN1mAlpcjjqz8622Fq3zXPgJv2KUESr+GXKt8jDPerPKVkh75nfOCVsY9OF2V
	6NxWhTvW6hg==
X-Google-Smtp-Source: AGHT+IFPy+tl7+AxfpEjRmmmBr1fzJCXikxqtgPCVv0GrHfPAOJOhlh2CsoU3/a7J5kRCTAHo+/4Nt2zcvp2
X-Received: from pfam16.prod.google.com ([2002:aa7:8a10:0:b0:78a:f444:b123])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2349:b0:781:6ce1:998a
 with SMTP id d2e1a72fcca58-78c98a73ca9mr7255831b3a.8.1759566928900; Sat, 04
 Oct 2025 01:35:28 -0700 (PDT)
Date: Sat, 04 Oct 2025 01:35:27 -0700
In-Reply-To: <20251002052215.1433055-1-kuniyu@google.com> (Kuniyuki Iwashima's
 message of "Thu, 2 Oct 2025 05:22:07 +0000")
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251002052215.1433055-1-kuniyu@google.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Message-ID: <dbx81pnjvzcg.fsf@ynaffit-andsys.c.googlers.com>
Subject: Re: [PATCH] cgroup: Disable preemption for cgrp->freezer.freeze_seq
 when CONFIG_PREEMPT_RT=y.
From: Tiffany Yang <ynaffit@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"=?utf-8?Q?Michal_Koutn=C3=BD?=" <mkoutny@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, cgroups@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, 
	syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Hi Kuniyuki,

Kuniyuki Iwashima <kuniyu@google.com> writes:

> syzbot reported the splat below. [0]

> Commit afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")
> introduced cgrp->freezer.freeze_seq.

> The writer side is under spin_lock_irq(), but the section is still
> preemptible with CONFIG_PREEMPT_RT=y.

> Let's wrap the section with preempt_{disable,enable}_nested().

> [0]:
> WARNING: CPU: 0 PID: 6076 at ./include/linux/seqlock.h:221  
> __seqprop_assert include/linux/seqlock.h:221 [inline]
> WARNING: CPU: 0 PID: 6076 at ./include/linux/seqlock.h:221  
> cgroup_do_freeze kernel/cgroup/freezer.c:182 [inline]
> WARNING: CPU: 0 PID: 6076 at ./include/linux/seqlock.h:221  
> cgroup_freeze+0x80a/0xf90 kernel/cgroup/freezer.c:309
> Modules linked in:
> CPU: 0 UID: 0 PID: 6076 Comm: syz.0.17 Not tainted syzkaller #0  
> PREEMPT_{RT,(full)}
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 08/18/2025
> RIP: 0010:__seqprop_assert include/linux/seqlock.h:221 [inline]
> RIP: 0010:cgroup_do_freeze kernel/cgroup/freezer.c:182 [inline]
> RIP: 0010:cgroup_freeze+0x80a/0xf90 kernel/cgroup/freezer.c:309
> Code: 90 e9 9e fb ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c e7 f9 ff  
> ff 4c 89 f7 e8 e1 43 67 00 e9 da f9 ff ff e8 17 68 06 00 90 <0f> 0b 90 e9  
> 10 fc ff ff 44 89 f9 80 e1 07 38 c1 48 8b 0c 24 0f 8c
> RSP: 0018:ffffc90003b178e0 EFLAGS: 00010293
> RAX: ffffffff81b6c6a9 RBX: 0000000000000000 RCX: ffff88803671bc00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc90003b17a70 R08: 0000000000000000 R09: 0000000000000000
> R10: dffffc0000000000 R11: fffffbfff1d6d2a7 R12: dffffc0000000000
> R13: 0000000000000000 R14: 0000000000000001 R15: ffff88803623a791
> FS:  00005555915ae500(0000) GS:ffff888127017000(0000)  
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b33363fff CR3: 0000000023b98000 CR4: 00000000003526f0
> Call Trace:
>   <TASK>
>   cgroup_freeze_write+0x156/0x1c0 kernel/cgroup/cgroup.c:4174
>   cgroup_file_write+0x39b/0x740 kernel/cgroup/cgroup.c:4312
>   kernfs_fop_write_iter+0x3b0/0x540 fs/kernfs/file.c:352
>   new_sync_write fs/read_write.c:593 [inline]
>   vfs_write+0x5d5/0xb40 fs/read_write.c:686
>   ksys_write+0x14b/0x260 fs/read_write.c:738
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f0dc3e9eec9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89  
> f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0  
> ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd9b7b6198 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f0dc40f5fa0 RCX: 00007f0dc3e9eec9
> RDX: 0000000000000012 RSI: 0000200000000200 RDI: 0000000000000004
> RBP: 00007f0dc3f21f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f0dc40f5fa0 R14: 00007f0dc40f5fa0 R15: 0000000000000003
>   </TASK>

> Fixes: afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")
> Reported-by: syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
> Closes:  
> https://lore.kernel.org/all/68de0b21.050a0220.25d7ab.077d.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>   kernel/cgroup/freezer.c | 2 ++
>   1 file changed, 2 insertions(+)

> diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
> index 6c18854bff34..7e779c8a6f89 100644
> --- a/kernel/cgroup/freezer.c
> +++ b/kernel/cgroup/freezer.c
> @@ -179,6 +179,7 @@ static void cgroup_do_freeze(struct cgroup *cgrp,  
> bool freeze, u64 ts_nsec)
>   	lockdep_assert_held(&cgroup_mutex);

>   	spin_lock_irq(&css_set_lock);
> +	preempt_disable_nested();
>   	write_seqcount_begin(&cgrp->freezer.freeze_seq);
>   	if (freeze) {
>   		set_bit(CGRP_FREEZE, &cgrp->flags);
> @@ -189,6 +190,7 @@ static void cgroup_do_freeze(struct cgroup *cgrp,  
> bool freeze, u64 ts_nsec)
>   			cgrp->freezer.freeze_start_nsec);
>   	}
>   	write_seqcount_end(&cgrp->freezer.freeze_seq);
> +	preempt_enable_nested();
>   	spin_unlock_irq(&css_set_lock);

>   	if (freeze)

Thank you for looking into this! I really appreciate it!

-- 
Tiffany Y. Yang
