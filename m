Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385FE22A7E5
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Oct 2025 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422158; cv=none; b=Gey/ZnFrlWKCsGEETIIjEEmKo9LpRyknTO+BM417YgGtZKCNXKv7eBcdZfk9rhr65xyXXdcbeaHvW5lXWlAxpwFU9ObbTVW6X37T/N6nFsgyf5/68F1RTicgh9LT6zJUADJOSciG/YjbO7+uzRyruhXoW/AaS4iK/ug6vxMr0OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422158; c=relaxed/simple;
	bh=QGIybxUWIo/fpWjPlVkioQPIUWX0XI99dAus9iHNj90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xk6Mvh6bbPT52GOocHuZ8qOyljRO5bBliyhl4dAle6zdXJBI1USRH9jws6YZTgfKvBBux3Rn5nuvGykNOP14ElfHczDz7pVqKfdDlfuGMMqHsRzPbvCjfeaD7fkGDmpI/ipK6/x/pR426viC/qJmAagZqFRPDBJwvwJyFNvZ6Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ur6coFX0; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ur6coFX0"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b55517e74e3so1409277a12.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Oct 2025 09:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759422156; x=1760026956; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcmW+Ew4uz5zHRnSkRPvLKByvtHyprDgk3Fv0lQQWSQ=;
        b=Ur6coFX0L7gX23dqKrXxT/fo6hUqDZPu9bc56Vwupu7gN59ZEOZu00JkAeaLk7BcUK
         Sd49Cz/SacKst5QUl8j+0llrPuWzpryN6w5hdgjFo6ZHtO1zOGxRZMxfvX7WogpyfSpp
         Q24MVERzwnJmnfC+aOco2+8L57oSF3czxPG/ew0nTNRysPFBkpOp/68SshKyigAaZIgF
         +oJ+lG91FSm5dW/8/0tSjxiM1PkGh/BEs+WQo4apN8uJN0/Xi6wCW78iXnYN0PJ0WgdH
         TE9TdZ8gqw4KDWN5WTQzOxblWZRD6sF2PbxvyXJ0XcWg61uDZLiE4DH3x+m1eo5VZ+ux
         K8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759422156; x=1760026956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcmW+Ew4uz5zHRnSkRPvLKByvtHyprDgk3Fv0lQQWSQ=;
        b=Dz8ZLJV3lQ2s5J5GFeKR9cxNKSU5+/hZK61A5yu0NcK6mJiOcxuEbF9hqIto2Rj11K
         aI5QpC9JPqbS0htt7OofCZFWrpF2UBmaM25ZUdKtsXqcMTUWfx+SzJebVzBIqLQwQkn8
         ZYKyhSvfGKnhi/OKYAO+e3Tg1uQflaN6LpgKSziezVgvY7Qa0eUC6EBGsapnVSjcPfaN
         7CGAU/5DemPSHxXk0o0DHa2qlNYElyc3lCUw7rTkRkSR8PtDNAUXWZ6AOFUaqcl3+ZfN
         wdhLBYbN9pprriBaXr+5+2oitswsFIunR+QMYIAk3Fi6uBPQtjx5hi37ylOnaOVQxhVe
         9veg==
X-Forwarded-Encrypted: i=1; AJvYcCXV/6tPDv1lMNqEOgDkjCNWNu+74e41ZTTFCVRB1UJcPSqKNZg+DhuPPMGmXH9bdJZe3aS4kaedcgk6Fceo0g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXL47UA4SM0mT+2pngSaCdm7bizHjZOD2jNTOQnq7H843rrwUj
	vs7AkEpiY5xsrm5u6Ih4FNjsNbsYZYU9aKOKqtsJq6LOwe/6aiPM99ZfVUTYtiZqoXcB+lP4rHX
	8W8uQmJfcfFmjD6sgHCCcjfHdaJq0DMrJLNT2DCX1
X-Gm-Gg: ASbGnctJIcHF2dkBZ01CJKOhogVZ1z1yQkgX6AoCMtVpjBc9EkDOzCQ2xlrB7Lo7I8Y
	q6LUgyHmF90dJF4AVlBS2so7Ql3WLie5e5lroxJUx/2HqvD1JKBbfUz8TR/XOAvpg58B9UrjpvY
	0IxYbW6suDs0Cwg7wApKQBvt02kBnMooXNpys0GlohxxIz4VJW9MHvP5Xo8vmfI8HxoyQPHgGzE
	1vgj4yZNLxYG4VHO7ctwLcKbQOcWl+nos77xsXunVdDwLd474w62jm6YhWm0/pu78vfTLU=
X-Google-Smtp-Source: AGHT+IFNTFrPHAbMV6/5Qvwr8vn9kT2v4YCrJnA1lgWdmelrsTV01jk/KvXHXcMsIf5vGWtTWuLVhQ+tJtc1zoQqtkk=
X-Received: by 2002:a17:902:e552:b0:24b:24dc:91a7 with SMTP id
 d9443c01a7336-28e7f2ff464mr99197155ad.45.1759422156184; Thu, 02 Oct 2025
 09:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251002052215.1433055-1-kuniyu@google.com> <5k5g5hlc4pz4cafreojc5qtmp364ev3zxkmahwk4yx7c25fm67@gdxsaj5mwy2j>
In-Reply-To: <5k5g5hlc4pz4cafreojc5qtmp364ev3zxkmahwk4yx7c25fm67@gdxsaj5mwy2j>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 2 Oct 2025 09:22:25 -0700
X-Gm-Features: AS18NWAIrcPS3jKugFFIcPfVpeqpTYVrB7j_tzhODluDiOsPr4J2TubIgApxZCc
Message-ID: <CAAVpQUCQaGbV1fUnHWCTqrFmXntpKfg7Gduf+Ezi2e-QMFUTRQ@mail.gmail.com>
Subject: Re: [PATCH] cgroup: Disable preemption for cgrp->freezer.freeze_seq
 when CONFIG_PREEMPT_RT=y.
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tiffany Yang <ynaffit@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, cgroups@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, 
	syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 1:28=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.com=
> wrote:
>
> Hello.
>
> Thanks for looking into this Kuniyuki.
>
> On Thu, Oct 02, 2025 at 05:22:07AM +0000, Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> > The writer side is under spin_lock_irq(), but the section is still
> > preemptible with CONFIG_PREEMPT_RT=3Dy.
>
> I see similar construction in other places, e.g.
>         mems_allowed_seq in set_mems_allowed

IIUC, local_irq_save() or local_irq_disable() is used
for the writer of mems_allowed_seq, so there should
be not preemptible.



>         period_seqcount in ioc_start_period
>         pidmap_lock_seq in alloc_pid/pidfs_add_pid

These two seem to have the same problem.

> (where their outer lock becomes preemptible on PREEMPT_RT.)
>
> > Let's wrap the section with preempt_{disable,enable}_nested().
>
> Is it better to wrap them all (for CONFIG_PREEMPT_RT=3Dy) or should they
> become seqlock_t on CONFIG_PREEMPT_RT=3Dy?

I think wrapping them would be better as the wrapper is just
an lockdep assertion when PREEMPT_RT=3Dn

Thanks!
