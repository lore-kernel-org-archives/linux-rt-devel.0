Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0DA2DA76D
	for <linux-rt-devel@lists.linux.dev>; Fri, 24 Oct 2025 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338649; cv=none; b=lZVrc47/1mZLtKXzEJjELg24vYcL6ArbGmI2evb1E6u5YE7q7i8c3SZIt4HcatGB8vQ3feYC3Mlgq+u+dDzITO5oqMiVWTwPX8nGpE8gQIVPdkF3Z8Ow560vRwiuu7ttvQo7v7VLhUWcJrRKd1lGsZxL39cOEenP+YGqJ54kCk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338649; c=relaxed/simple;
	bh=RNvLYaINM6n6Q8orahjUExiUrP2C5m6sUpUU/3kkhqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7rhz2VAxU3D97nchZLJ25H4lvwlttrEcJ/85XrriTT2C6SAJW13IO4zAE601l04+Pyz16M6ftPLPxiCwMt/5XJ8Jx7w7QSxFv9oFQhW7bNsLiCalgLthRF3qyq94FqlvThML3oCTCvo30rQQ7mQfUKser6GRz0/37h/9ZlCM2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGYf5Dlp; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGYf5Dlp"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso2565202f8f.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 24 Oct 2025 13:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761338644; x=1761943444; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxHcVaFJP8LSAUbqjjuozojLxS3r7R2EKYoJfzV0av8=;
        b=DGYf5DlpQf86/BFOErA6FcNSFqjgdfsdmjolT3mPjRjLEytXctLweLPdl3Fa8EvpZS
         +BSJuwzE7aIX4lVncFKXvGiOBlBYevOE1/HwYwgG/wGyv1r4XRe9/1fOa5uhpQqJhgWl
         9K009cm4K30tx5/ixTCNHgByLn90D9NwWMwec0h1L8geOs9b2vtxlQo2qMrwH/uJv3Vm
         1VdHWNdnalInVRze/sCOZHlTm3klu8fAMTf8ltt2rJM/GTLXt2zlQEmMVmtc9vNM566l
         bn3nAT4waNJhGYKOixz1LZ7Kg5LbrVHbKeK4UjskcFzNS3eP/ZIpY2qhbFEXpZ+zsiSh
         x26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761338644; x=1761943444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxHcVaFJP8LSAUbqjjuozojLxS3r7R2EKYoJfzV0av8=;
        b=Axx40+ReWrbyMLNNJtW2o4z1QB9l0s2Ht0yfo4yL6sE5ShrZQ27CpJA25ad319Mrhc
         j1XI/7M/NeoPRosaE+1eQedmjos1bkACGjl61coBRAEh8m4ZoSKTwvnHxf2SplBxx4zq
         COqc68tai/lXTlbpjAOyJ9e4eTrcAgorLyu4K3jMj52SC9EPCNV93zw0/QZBA7mM2bvp
         1uvOVdti2TEjFKi5N66J9nK99gB5aecoqsFvXt4r7gXuBBppHcNWawCT6JrPpXKdgwGu
         Gl3IdPCyTPlsHnugIqv7jkKhZnECGuQYroZU8QCKhpZ+CoOXVpBNwJxQP2Nma9gs5j7A
         7gPw==
X-Forwarded-Encrypted: i=1; AJvYcCXw9rRASgSEoZ7pkYXsCpeNhviUhFYB1B9FTLdUTCeuSE2Jq7roK6akWjkEqcLj0DZDelFndCjWHHDf4NMfIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLQgluws150u6kxHHUm16yevSqCjvscL+sKPVSVsmlgu7pmQBE
	hx2pO6I74Hh6uFDUnoPa1nfLb5edXreaEWsZGQH1UZuM1d0IQYWIvwPWEKIA/nW9WonX2QWK1/D
	REf0SFr7/PBtN1cWNTzhnUzq0MA8AOp4=
X-Gm-Gg: ASbGncvoZCU4jXmxXFkm7VwasZwFJvFMlKFSulofRfruTD1v1P1an6c/YVyJLyjLMWq
	pdmUP5bfu1ReQOB7avQoxKeViKjrRQI9+TYfQysW975LoEOwXVIpXavdS85zf4d3FIf0PJA1kfi
	ZWEe9z6Mft0M+WuHR+7sosYn3gLbJdpxwJdypZTGCvjvNyLyy/K4C2j2xjXXbT+4ILTDqY3FpbQ
	Ntpn5ThdoEBQWdbjHgkH6lpD63WjyWVfS95LP+wiAqVop7fF3gXlDqVdvTphdBaXqnj1RxMkSGm
	+BKv6a71ZFkwt69SQXlwEPEtb3JR
X-Google-Smtp-Source: AGHT+IGLFt1YCHWbNyJyaEpr+22LPb9d3Q1kWYq7cFolvy1jDcRdvp0v3rx52ay4vxC3D1vRjgD3rmqs6Qx2J3gTPG4=
X-Received: by 2002:a05:6000:26d2:b0:429:8a81:3f4d with SMTP id
 ffacd0b85a97d-4299075ca93mr3213632f8f.63.1761338643874; Fri, 24 Oct 2025
 13:44:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz> <20251023-sheaves-for-all-v1-11-6ffa2c9941c0@suse.cz>
In-Reply-To: <20251023-sheaves-for-all-v1-11-6ffa2c9941c0@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 Oct 2025 13:43:52 -0700
X-Gm-Features: AWmQ_bnqGo3VhvdnD4VDhLrtr6dWJQ16k-K7Ue44kfB0ODJ6fAEdUY4Nt58fKuE
Message-ID: <CAADnVQKBPF8g3JgbCrcGFx35Bujmta2vnJGM9pgpcLq1-wqLHg@mail.gmail.com>
Subject: Re: [PATCH RFC 11/19] slab: remove SLUB_CPU_PARTIAL
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 6:53=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
>  static bool has_pcs_used(int cpu, struct kmem_cache *s)
> @@ -5599,21 +5429,18 @@ static void __slab_free(struct kmem_cache *s, str=
uct slab *slab,
>                 new.inuse -=3D cnt;
>                 if ((!new.inuse || !prior) && !was_frozen) {
>                         /* Needs to be taken off a list */
> -                       if (!kmem_cache_has_cpu_partial(s) || prior) {

I'm struggling to convince myself that it's correct.
Losing '|| prior' means that we will be grabbing
this "speculative" spin_lock much more often.
While before the change we need spin_lock only when
slab was partially empty
(assuming cpu_partial was on for caches where performance matters).

Also what about later check:
if (prior && !on_node_partial) {
       spin_unlock_irqrestore(&n->list_lock, flags);
       return;
}
and
if (unlikely(!prior)) {
                add_partial(n, slab, DEACTIVATE_TO_TAIL);

Say, new.inuse =3D=3D 0 then 'n' will be set,
do we lose the slab?
Because before the change it would be added to put_cpu_partial() ?

but... since AI didn't find any bugs here, I must be wrong :)
