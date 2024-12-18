Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85554481B3
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Dec 2024 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734538677; cv=none; b=oVHJU6KZIgSCGAZnVebY74QfyLqgx4lZ47MLGtBvK/lT2fd8Y3ZyNSl3g4CZJaGw21mX9soS6l0xFkE8DVGE//ZQOLCNo8xgRt04fuRq5dDSTD4sswvFYPG2DzaNQ85cnQuHdIAJG760+LbbxknzBPFmBK8Ke9m2vgRTnMGl+u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734538677; c=relaxed/simple;
	bh=ZrmwzPxEk0MP0STSEZ6MlfIKA5hNSsabqC2eHlL0/Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4sgTAOrKgmYmoSwImP1kxa60ztpegrihpf9ynt4SZC2mWuA6wjmtpAvyofcp38SPGCx7XbIAF6cTPY+BxxcWFN4EifbKVG9tG/5eEIgOiimuVhd/yUaqSa7y7qGUAHqzwpXW3rtmv67NoaiIGMMOaWBJhPF0py2UGW2AxF/SUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D0rn+N2Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FlXJvDHh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D0rn+N2Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FlXJvDHh"
Date: Wed, 18 Dec 2024 17:17:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734538672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gl4PyUXwFPzZyEQNIKCuf8t1ptfccSRsh0pr8uzkPO0=;
	b=D0rn+N2QqEHELWpCzcNjZmHZFTPkJkqOLNTZJEcNZI9LFjr4AwanrcW5YIDM4aFRKl140G
	vvHBNPmQpxORtbxVesVhy5kVVoO+ZJQpYXkGEJNGYWm6D8h9Op3JVjfIqNFfBl8qFST4UM
	OZtthP6b4zE4SyiI+CKYUYy2vjSGDcxb+3eVsn8w4b0O0DvE4ugjzyq8C+Do7vHpocL0uT
	MQpRMKYP5/Zz8EjGe2Lka6g/js1uS8v+Cjegbi/+ifm/1f+8eiubxZ4zrJrwFTU+OWzV4W
	HTVTdX1dC51Pv0dGuO4f+v9SRf2YpYYJYHh7SGn7ByWpzXDBSEI70XqRN4CBgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734538672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gl4PyUXwFPzZyEQNIKCuf8t1ptfccSRsh0pr8uzkPO0=;
	b=FlXJvDHhAbDiEX47mg/8/f6D279Qd5Za4fjajV7kIoZ1MgKvTMkMx7UUVy476Xp88PCbec
	Gm5XKedNNLIjcQDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alessandro Carminati <acarmina@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Eric Chanudet <echanude@redhat.com>, clement.leger@bootlin.com
Subject: Re: [PATCH v2] mm/kmemleak: Fix sleeping function called from
 invalid context at print message
Message-ID: <20241218161751.gYbwFkzd@linutronix.de>
References: <20241217142032.55793-1-acarmina@redhat.com>
 <20241217095504.ea2a3a24564af4df48cf0b19@linux-foundation.org>
 <CAGegRW7qRpPLWJ7Q_j-J1fsKfxvv6+m_8N5q9QVZL6jgUz9cqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAGegRW7qRpPLWJ7Q_j-J1fsKfxvv6+m_8N5q9QVZL6jgUz9cqw@mail.gmail.com>

On 2024-12-18 09:38:05 [+0100], Alessandro Carminati wrote:
> On Tue, Dec 17, 2024 at 6:55=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Tue, 17 Dec 2024 14:20:33 +0000 Alessandro Carminati <acarmina@redha=
t.com> wrote:
> >
> > > Address a bug in the kernel that triggers a "sleeping function called=
 from
> > > invalid context" warning when /sys/kernel/debug/kmemleak is printed u=
nder
> > > specific conditions:
> > > - CONFIG_PREEMPT_RT=3Dy
> > > - Set SELinux as the LSM for the system
> > > - Set kptr_restrict to 1
> > > - kmemleak buffer contains at least one item
> > >
> > > BUG: sleeping function called from invalid context at kernel/locking/=
spinlock_rt.c:48
> > > in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 136, name: cat
> >
> > -rt is a bit annoying this way.  Things which we expect to work OK are
> > no longer doing so.

Yeah. But lockdep should have complained here earlier. The RT just
enforces that part.

> > > --- a/mm/kmemleak.c
> > > +++ b/mm/kmemleak.c
> > > @@ -373,7 +373,7 @@ static void print_unreferenced(struct seq_file *s=
eq,
> > >
> > >       for (i =3D 0; i < nr_entries; i++) {
> > >               void *ptr =3D (void *)entries[i];
> > > -             warn_or_seq_printf(seq, "    [<%pK>] %pS\n", ptr, ptr);
> > > +             warn_or_seq_printf(seq, "    %pS\n", ptr);
> > >       }
> > >  }
> >
> > Before 3a6f33d86baa we were still printing the address, with plain old
> > %p.  Should we restore that, or is %p always useless?
> >
>=20
> The intent of 3a6f33d86baa8 is to make pointers available for debugging
> purposes.
> My argument for this change is that %pS provides already sufficient
> information for debugging purposes.
>=20
> We essentially have two scenarios concerning %pS:
> 1. When the symbol can be resolved by kallsyms: In this case, a
>    symbol+offset style pointer is emitted, which I find more useful than
>    just the address.

indeed. With the relocation the information is usually hard to make
sense.

> 2. When the symbol cannot be resolved by kallsyms: Here, the raw pointer
>    is emitted. This undermines the original intent of %pK, as both the
>    masked address and the plain address are exposed.
>=20
> If we want to be picky, there's an additional factor to consider: KASLR.
> %pS emits its output accounting for randomization, but in most cases, the
> randomized offset information is lost.
> The exception is when the symbol cannot be resolved by kallsyms, though
> this should be rare. It's still worth mentioning.
>=20
> Back to your question: %p emits an hashed address that is not
> reversible by design.
> Therefore, in my opinion, it is not particularly useful in a debug
> message.

There is still %px if you want your debug message to show the raw
pointer regardless of pointer hashing. That is something that you could
disable. The %pK format is something that was meant to be used files
like proc or sysfs. With the restrictions you already have on dmesg it
does not seem necessary to have yet another check.

Thank you the patch.

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
