Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914CFCA5A
	for <linux-rt-devel@lists.linux.dev>; Sat, 16 Nov 2024 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731775384; cv=none; b=FRNYqXU/66XZTE3J336WjCxcpPAPiEdae+NsvfQsaILllDechxmnJsSE35hPjZGOpg0vzoBj2ZqZRcs6mS4OIVaHoCqfQgmxxte4lXaeKYk+CPa8/BSMhtJ2jJ91qw9LkhHT2jCxFbE7p1Tvv5eMFObsZHxDo7khaWd53gSLWMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731775384; c=relaxed/simple;
	bh=pYjbgnkOs1b1lmociUmZeMIJViJjLIkw8QLnkNEo5dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwrY75F9iaRF61WPJv7l770W2WWMj1ERWOCwFfSe/xAD5kMtraWqTyiT5PkrHyU1cG64Q4HexQHZ5VySIhAl8i3NvBVTak70T4g9NZvJqqxYfPWjEjL1YRuWRg7MYIFnbxgh2lymK+BpIYqx7eOME+BcVO9xaF9AdWbniArZeRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6jZOVx6; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6jZOVx6"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d462c91a9so1933740f8f.2
        for <linux-rt-devel@lists.linux.dev>; Sat, 16 Nov 2024 08:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731775381; x=1732380181; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYjbgnkOs1b1lmociUmZeMIJViJjLIkw8QLnkNEo5dA=;
        b=d6jZOVx6LZMziLrmC4eRHywIYeCh5xHso2GWjz18Fc5bNF/uAIE/YYIqbAKK4nnsCv
         bZ+C8AcRu44lKT9RwYo2zzFkn0/qZkmAh4QW2e/Nmg1kh043sQzgyC7AvaIP1Sos/zVt
         wkcgFU82/nz4zfr2iuTSAo5gtwudS4cBEvdd1X7NXNZD6EupfVIupn0kq7fpvY0y1fhC
         jIZwK+Dzp9rRSnU0xnz0R/ZzpXhh2gbprQOEinjaQ7KsuB2ySaZBLd9KbFxMmulQaa/D
         kGZiEeO6bRyr0G10oOhWogG5ByP4ugg6JuiYBGdK/S1m23vnyjMOiESZ5/BDPTlo1c+m
         USpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731775381; x=1732380181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYjbgnkOs1b1lmociUmZeMIJViJjLIkw8QLnkNEo5dA=;
        b=e9sbDvoBfha2Mo4sqZb/p/T6fPS158xWpY0mWyobxOEmoYd3E77OgHU/8U8DCwVnbr
         Pcsq+BHt8kViS6QJGMS1wkPAJAlZP339KtLYVbXAztuD0bjxddaPQm7nn2G/dbKJCd7N
         /YSr0jGc86B10coCVMEBFVaEGZv8dF591Pc/1Ozem6Lds1+Pg5p5tY3qC5W+yhBOCxiw
         fnakOPNNW6E3RXht/JrsAjyfY0ZUsmmW6BBZnXys92yxz3V8QFYmhUe59ZBpsSyfEmK7
         TasRZ/VQCOCeXSAvnyo2sUOGyftNlayC2ng2JWC1EDpnKoAW3qKQlYquLX+BLESoSHaV
         5hgg==
X-Forwarded-Encrypted: i=1; AJvYcCUTQV/nkn+PxRUqXZCHq7KGaslNKHpyAUMlyLlRFN+gR1xK+DLkp6nWQXKYNoBqVmFGAnrt14eqnw7CK8mNHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwrabNN8HTFGwZGP3x6Bd9nPfXVmaV8NArNGV87pPxqWKJ+dDrv
	t6qhRV6nPyI7FhVT6sKeIQQbBQvKLZKhi1FvOOjuI/4dWx4p+q6OyGBBPEOjnAROOXcNqgW/m9v
	erDaAb0rqkmRaeJYTq3r16d6OO5I=
X-Google-Smtp-Source: AGHT+IHZuIblvCjZxwjk9MUHPMHsNmj3JdzxQOOvtr63PNRuKmUVsEBKip1QMj+H+7R1Ymgzl0upNJPmM4UPzjOeT6U=
X-Received: by 2002:a5d:64c8:0:b0:382:2276:c93c with SMTP id
 ffacd0b85a97d-38225a8a36cmr6494006f8f.44.1731775380800; Sat, 16 Nov 2024
 08:43:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241108063214.578120-1-kunwu.chan@linux.dev> <87v7wsmqv4.ffs@tglx>
 <1e5910b1-ea54-4b7a-a68b-a02634a517dd@linux.dev> <87sersyvuc.ffs@tglx>
 <20241116092102.O_30pj9W@linutronix.de> <CAADnVQ+ToRZ6ZQL44Z9TAn6c=ecqrDgrnJenH7-miHJSWe7Nsw@mail.gmail.com>
 <1ed46394-f065-4e8b-8f37-c450b0c1b3a9@t-8ch.de>
In-Reply-To: <1ed46394-f065-4e8b-8f37-c450b0c1b3a9@t-8ch.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 16 Nov 2024 08:42:49 -0800
Message-ID: <CAADnVQJBGKioLA0JuyCQdD-jRKn2bpb7A7r6Yo4drBb9G1tvbg@mail.gmail.com>
Subject: Re: [PATCH] bpf: Convert lpm_trie::lock to 'raw_spinlock_t'
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Kunwu Chan <kunwu.chan@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, clrkwllms@kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 8:15=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> On 2024-11-16 08:01:49-0800, Alexei Starovoitov wrote:
> > On Sat, Nov 16, 2024 at 1:21=E2=80=AFAM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > >
> > > On 2024-11-15 23:29:31 [+0100], Thomas Gleixner wrote:
> > > > IIRC, BPF has it's own allocator which can be used everywhere.
> > >
> > > Thomas Wei=C3=9Fschuh made something. It appears to work. Need to tak=
e a
> > > closer look.
> >
> > Any more details?
> > bpf_mem_alloc is a stop gap.
>
> It is indeed using bpf_mem_alloc.
> It is a fairly straightforward conversion, using one cache for
> intermediate and one for non-intermediate nodes.

Sounds like you're proposing to allocate two lpm specific bpf_ma-s ?
Just use bpf_global_ma.
More ma-s means more memory pinned in bpf specific freelists.
That's the main reason to teach slub and page_alloc about bpf requirements.
All memory should be shared by all subsystems.
Custom memory pools / freelists, whether it's bpf, networking
or whatever else, is a pain point for somebody.
The kernel needs to be optimal for all use cases.

> I'll try to send it early next week.

Looking forward.

> > As Vlastimil Babka suggested long ago:
> > https://lwn.net/Articles/974138/
> > "...next on the target list is the special allocator used by the BPF
> > subsystem. This allocator is intended to succeed in any calling
> > context, including in non-maskable interrupts (NMIs). BPF maintainer
> > Alexei Starovoitov is evidently in favor of this removal if SLUB is
> > able to handle the same use cases..."
> >
> > Here is the first step:
> > https://lore.kernel.org/bpf/20241116014854.55141-1-alexei.starovoitov@g=
mail.com/
