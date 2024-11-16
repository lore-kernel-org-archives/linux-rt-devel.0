Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB841885BD
	for <linux-rt-devel@lists.linux.dev>; Sat, 16 Nov 2024 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731772924; cv=none; b=VdaH5KOPU+oLpin97ukeSLzcKGijLHxuN5bM0xZRtrsGgUvru0xjLnYm0Ks5sM+zdwzW/QVlDGgyvrqmRPw4ona9R4eRS81zYGSHhsxWE5IcSMTkLMjIjsfH3M7vG7S2o1K2xT1rHsC5Kz09dly0sbSZAmZ8eIcOX2zsq27zQiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731772924; c=relaxed/simple;
	bh=UijMnMV8wUCIx8JQ6HHv3iRulp3nmwiDHx+zhV5iZRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oyc4EqiiNGD8NZlOC17ZWuMHYi4tmVnnvneVkp0szCQrTL/Wu5O6ExZXwlrdvQyw9eZOZp1UI1KlBAQ+D/v7oAzs4ZeDdw/VnZT5x6kk5ZT+9zim8qOGlUKB+PzPxoZqn8crWNBuSio0wNleGBNPKzVvIzf8TvDnvPyF3FCLpbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kASW8lYr; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kASW8lYr"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3823cf963f1so153313f8f.1
        for <linux-rt-devel@lists.linux.dev>; Sat, 16 Nov 2024 08:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731772921; x=1732377721; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UijMnMV8wUCIx8JQ6HHv3iRulp3nmwiDHx+zhV5iZRI=;
        b=kASW8lYrsWu3gQYpPOjZbIb2wegD0C/s7ESMhR7PiKhn395EaP8PI/aM8aii0IyJpk
         SDZMej57wRebHtsaSSwwvzx0h9cyyLI9dnKsGIXjrRX6TCk1AUWbaDfZRem84Vwf5Wil
         8DaZO4qV7kkKxMYiYZgEs21c7h2bj7UEwoM32OU2NmJ6j2O9TZ39RKlOv0KK+mxd1x5E
         JeUTdNpEu/r80I+c3J/eF2UPhNEfmlP/tKNAEAHPbC8YV8avykauJVlCj2e3hJjVexP1
         gaOIcwN+m9GZl5tXAu+DCw+9EYUK4n+7bU4WLWZfMdsO6ffsYyE23QDOqIFe6Ahu3dBA
         NbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731772921; x=1732377721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UijMnMV8wUCIx8JQ6HHv3iRulp3nmwiDHx+zhV5iZRI=;
        b=jz39UW7Y9/gIm7QISfRsIheclYG5QiYqs1EPbtZp/53esdqG2cuZg+pwS7j0KA+r93
         13QqVKKg6AeRW9Y8yZ18S2nqmg5lKN19x0wOmI+gYjtM3ubsHUnfpe/dG7Vf3ooDaKfF
         5kyZsX1xEPVOQw9zpnFPlfVSpsSjUqcRcT8JloKS5u+26eQuaCkb+Kt0LZhHkHwmooa/
         286IpESyn5fs3FUCGoBHjUKhfSfL3Wt700W3WKg/04FTWVW+KKyrafYBJmxMRuRgGNLn
         7uG1qN96loJNy+M770DorWKx6RBfa3ujNqKybNXNfBxFgL9G9ec9wYVZWbmFqMRJExgU
         mu3w==
X-Forwarded-Encrypted: i=1; AJvYcCWbTeLDmh+c01g8SkNRaZWmBEkyrszP/FlScOuI+WERv+zcXqNMD/9+xOtB8B81xEtmfSfmMcFcY5HghiWE1w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxz0x+p4sCH44IZ4/Wvc4sVSD96JA/E2Es+xmh0B5PskSNr48jP
	eRwKzNc+I1v0i2lflD2ueEK+RdYk0WAGYG05tDV7DGOjPv9Ny0GjQifoN7hYyDptFYRKMpB7XsS
	7y2nVIldovcw1E4mF8qtnAaGNxwU=
X-Google-Smtp-Source: AGHT+IFQ/o+7fboa/cFjS9jNYnRv2Xn1kVPcEe2go1Tliw6ReETIuha0jykNvpXLIypVYBUW8aqD3xeOXhVojofPA0A=
X-Received: by 2002:a05:6000:4619:b0:382:1e06:fb2 with SMTP id
 ffacd0b85a97d-38225a92035mr5439250f8f.38.1731772921103; Sat, 16 Nov 2024
 08:02:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241108063214.578120-1-kunwu.chan@linux.dev> <87v7wsmqv4.ffs@tglx>
 <1e5910b1-ea54-4b7a-a68b-a02634a517dd@linux.dev> <87sersyvuc.ffs@tglx> <20241116092102.O_30pj9W@linutronix.de>
In-Reply-To: <20241116092102.O_30pj9W@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 16 Nov 2024 08:01:49 -0800
Message-ID: <CAADnVQ+ToRZ6ZQL44Z9TAn6c=ecqrDgrnJenH7-miHJSWe7Nsw@mail.gmail.com>
Subject: Re: [PATCH] bpf: Convert lpm_trie::lock to 'raw_spinlock_t'
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Kunwu Chan <kunwu.chan@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	clrkwllms@kernel.org, Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 1:21=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-11-15 23:29:31 [+0100], Thomas Gleixner wrote:
> > IIRC, BPF has it's own allocator which can be used everywhere.
>
> Thomas Wei=C3=9Fschuh made something. It appears to work. Need to take a
> closer look.

Any more details?
bpf_mem_alloc is a stop gap.
As Vlastimil Babka suggested long ago:
https://lwn.net/Articles/974138/
"...next on the target list is the special allocator used by the BPF
subsystem. This allocator is intended to succeed in any calling
context, including in non-maskable interrupts (NMIs). BPF maintainer
Alexei Starovoitov is evidently in favor of this removal if SLUB is
able to handle the same use cases..."

Here is the first step:
https://lore.kernel.org/bpf/20241116014854.55141-1-alexei.starovoitov@gmail=
.com/
