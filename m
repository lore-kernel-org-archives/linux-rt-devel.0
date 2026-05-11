Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDA637BE89
	for <linux-rt-devel@lists.linux.dev>; Mon, 11 May 2026 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521711; cv=none; b=ZCjc6hHLsdl7Ml32LhsP2ekhIhXJi2uj5dZiPJH1V1N616QD+qnwGd+ojC/FTH6VrL9UPKWryhqn1q6B7MuKVVtzpDd7HzKZVwpfYi+GnXxgWU4GAo2Gthhhp/cPwCsypbeYObffGdQFFQBHp0iPOLyYzg4AodvMFXtO5uIIENg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521711; c=relaxed/simple;
	bh=g0HM4wRy7nS4KwsGK2W4xicmwjdHjeZXsgcIgL8YAH8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oq5A8/6tVvv0vsWr3L7/NZySeACH3T9wHHA7pe8oxz737Lu6srBmx1LlZ2/hwqWK62UBDMJjjQR8GpbH3sso8wrpqey+PsnN2hL19yPxxMZ9zy12ejAS0Yfk+OxOLumi0cQeq00nm+LY1YalFXx9WovWeflj5PGCXQblNk3fyg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l4Ouza1v; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l4Ouza1v"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa860e71eso2476181b3a.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 11 May 2026 10:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778521710; x=1779126510; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zxTSC2plskcs/9y0k8jlg3lj1e2pspt2n223yRFDS4=;
        b=l4Ouza1vOz6aDmh6mF42gPXBeuK0lvhx4/f6ZlD4AvoLn2TsiTrXstrj1F6sclT3Op
         XP2/f1LuHJ+4R2M3ycewavNxHNX10KaQoHbyNUMeV/Zli1PGJzem2A406kq1qaDk20hJ
         VwejAvAAgtFEJdBk+lcnoHrN/MTDFXetfXy7JF0yDJRA6OZtAEb9iM1RT9rTEfwGoJX/
         WvRhZm/eoyMG1Bb+mEE8vZhCMgTx9UEZuifUYX8KVZ/w5reg6uOjGcX82VXeqZQXNUOU
         d/MVqeEnUS0Sh8DFRENTlTNZyNIswZgCVtlozxsk8idSRG2Xgm+ST+FHmudEoYPffjBN
         Q+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778521710; x=1779126510;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2zxTSC2plskcs/9y0k8jlg3lj1e2pspt2n223yRFDS4=;
        b=Mu3vtaXxYkN7IwULhYZo0Ib7fROWNQbSIOljEN0qaQ9XCkALI3yR+24K8w0GkB167C
         C4dKZ7DbSjezmflgOhPEDQ6WUeR3gyEd3rfXbQEokSLzipJPXxLCTzD0YRM9AcV4fU7y
         MAQhDvgjxlAIgvBD3HP2VsTAAwPYcBqNQyqsHdGc/BP2rBxsqu5N6oWO0On+pyQDZDhl
         1nCvdNBecBGavOBehhDwQK47Y8B8UA5XOhPRE+ZMAKhBg5x3WtyXpH/zkPmP23gYKXSB
         A2+WjhdMGB45SVa+5RmxXzT9xJP63EqKOEvvYPvVa6/LkGIR+qJQkE4YUZGX8PE4YZMk
         NJJA==
X-Forwarded-Encrypted: i=1; AFNElJ/aMj2zt5y8gOzku97P/X4Unn6l3gXnwEbi9frBNpqJkIpC1/hPGzYHj9s+YaslikNCOnvJabSeRKpTeXO95w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhQ75gO3LHIRCPxl5OAJXfkzdH++0ewpCJKt84FH/LXp/zKJWe
	PSoPZVB0AjMNlW1U22c144Y4v5tV4P3GIUqmoBSSUbRZ3R5tqOeT+Lt8WfH3Fha+qrRXOEE/WMS
	YcvnG5Q==
X-Received: from pfbgh1.prod.google.com ([2002:a05:6a00:6381:b0:82f:2f42:2da4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ad0b:b0:82f:74b2:7fba
 with SMTP id d2e1a72fcca58-83a5b3ca995mr25370247b3a.4.1778521709475; Mon, 11
 May 2026 10:48:29 -0700 (PDT)
Date: Mon, 11 May 2026 10:48:28 -0700
In-Reply-To: <28709d77abbecdd156c830fbef3c706431d2082a.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260508181717.3230988-1-dwmw2@infradead.org> <20260508181717.3230988-5-dwmw2@infradead.org>
 <agII-2_f_gYMdPzL@google.com> <28709d77abbecdd156c830fbef3c706431d2082a.camel@infradead.org>
Message-ID: <agIWbNDUgrpmD4VT@google.com>
Subject: Re: [PATCH 4/7] KVM: x86/xen: Remove unnecessary irqsave from GPC
 lock usage in xen.c
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Durrant <paul@xen.org>, Peter Zijlstra <peterz@infradead.org>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Mauricio Faria de Oliveira <mfo@igalia.com>, kernel-dev@igalia.com, 
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026, David Woodhouse wrote:
> On Mon, 2026-05-11 at 09:51 -0700, Sean Christopherson wrote:
> > On Fri, May 08, 2026, David Woodhouse wrote:
> > > From: David Woodhouse <dwmw@amazon.co.uk>
> > >=20
> > > Now that the hardirq path (xen_timer_callback and set_evtchn_fast) us=
es
> > > read_trylock() instead of read_lock_irqsave(), the remaining GPC lock
> > > users in xen.c are only called from process context (vcpu_run, ioctls=
).
> > > There is no need to disable interrupts to prevent concurrent access f=
rom
> > > a hardirq user, since the hardirq path no longer takes the lock.
> >=20
> > No longer _waits_ on the lock, correct?=C2=A0 I.e. the hardirq path can=
 still take the
> > lock, but only ever does so using trylock.
>=20
> Indeed so. Want me to fix that?

Nah, at least not yet.  I'm in the process of wrapping my head around all o=
f the
in-flight gpc series (namely yours and Fred's), just wanted to make sure I =
wasn't
missing something.

Thanks!
