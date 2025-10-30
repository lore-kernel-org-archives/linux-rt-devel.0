Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561901D88D7
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Oct 2025 00:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783869; cv=none; b=nhejTq8ID264ujZeccoZilGOBDF0ianxUVDmtWxAsyKSHAJex5Ggaz/NXgH0HagH8eDviA/nOmdxeOjoPFZJcW8K8A6Wqwh9l9ghpiusZNPfcJ2jQkVOgD/bk/WfrQvWJkMX+0z1A/+gtD3KqG3OwGqgMM4CPNvDANnuu8GnUuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783869; c=relaxed/simple;
	bh=epzPhO8vgI37OQJ5YBJFLRek4SKDfV+z2knwPznfnng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8d3G2lhQTIWCPoAxF/yT9uQmE1Bih5XOajppC1i8Sm6NAXipu1+Nb6MQnYiKbUH720Sg6woW4qNZldhUx7Krb/yDPkqN4WLfrs7adnwmGiyNsEBFd0fj7Gkrnbuto1nl0vLddMMKyC2xV35FJWfY5acSNbpfH/OsJCUIvoFx1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hITSSEnv; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hITSSEnv"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429b7eecf7cso31826f8f.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 29 Oct 2025 17:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761783867; x=1762388667; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epzPhO8vgI37OQJ5YBJFLRek4SKDfV+z2knwPznfnng=;
        b=hITSSEnvX+HG7bSmu/0w0Bn5h1BpG/G0AIVdbZGMI0+bDKMt076f4FAykd7odLcACY
         TrXcKk8XyRUmkZYwwqECmMVqJIFeJKtFIGTPlPviPA46Oo0hu60ZBE+o8jg9sTR8kb0X
         ZlyfIc/0f/awqin2Tjr3RbcHUYw34VUcNKNfZUEPQ9keDO4gA7Qd5to7wv/54eevCjnB
         4AVl/Jru10cDcnzzuNxRR0NMsTwsa2CehmpuSgWScdFGbZ7gVkxV25Qo5JFUdsC2vIIG
         WiQgGUg6XUbrCVCAUv6q3oksOzXxZc1Goho3xedVzxhKJMLaOkp8HF5fkaZrb36i6C09
         31Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761783867; x=1762388667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epzPhO8vgI37OQJ5YBJFLRek4SKDfV+z2knwPznfnng=;
        b=KXEGd4U+lgQdy/dmBJ/iFwZ9vK0qLL213MaR1RcY4i4hgXzfm7FXQYeZ5cKbVgZiNr
         a3Mcvfbe8APKOO1b2cw4tjE9+fvoBgmu6IoRHR8OP50LFlk5hx+bRlkl1d0XovmjbvND
         T84G+EC2+bTA0pMHAKfNr2FLp7jIVi4KdPS//kCcmTcf76aeac088YknZAy926/BsYwI
         u4GqsXOTb0L6rbVULkw+J2BMwmINH33yxAOYmBCpSzjjPH7JnNWpzebqhHZWKBaNCC2W
         e15K4z3AOA7U0Q5fqqpK9QIr6azMLpf88IPPISadSXnCFOaIzCM3vdjLoRYXj/dlKBQT
         3Acw==
X-Forwarded-Encrypted: i=1; AJvYcCVoUsuV+A4iuTShaoLt8Nk7wbSEmwmbtsY1hv/Ihywo/ivN/zDp6O2IMeSI4Gl4r+d+baRepqmVIoQUVpdnug==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx35raLdpX0/Y28+kVjEwnORmNxm6KGAB2izzrjMw5aZqSCgjjo
	4Y1vSAG1LssafyQ2o+PuE68uQMNLCxxMvgPSebwAJTn/T/UW24ymbtOAiC7RM11/asfeNJXXV30
	VmyH/mf7TP5QzBigGUiYrajdnUDdsfk0=
X-Gm-Gg: ASbGncsurjPx0gz8krIx1UZekkjPzsq17FASE8pPVFADpPlAjlPMKyUtbKntRH7xCrX
	ug2zmSQHtVQM6XZ8pyxDrHygXkqW6yL4d74c+jGxr4HZ1TknsS2Rc+f5bduf/QhDcp8DD4pXOsu
	xrOU+poSMH2MYrkkX19kKkYB9HzPz8kkunnYr2WwiIDOoHmECXgQ4cmW9Q8dKBvxcRRxmf31A9G
	Y/C6M6UfPHdh28uV+ALIEwW+oY/THGCfyUz1pRJ3/Q7XoVqgwvZ7v3nCTP4rGRJZY5IQV/wgdpm
	/kwbBp3pvrOPtZ5PBA==
X-Google-Smtp-Source: AGHT+IGrpyN5vXmTDxAJ2Hbps4KQtgd5KIZx2gAkx82y7AWs2BOA0ibbW+EbXbkybCTf6OBaGDisHC0/rb+R99V6Svo=
X-Received: by 2002:a05:6000:2584:b0:401:2cbf:ccad with SMTP id
 ffacd0b85a97d-429b4c56bbbmr1308255f8f.17.1761783866576; Wed, 29 Oct 2025
 17:24:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
 <20251023-sheaves-for-all-v1-12-6ffa2c9941c0@suse.cz> <CAADnVQ+nAA5OeCbjskbrtgYbPR4Mp-MtOfeXoQE5LUgcZOawEQ@mail.gmail.com>
 <a110ffdb-1e87-4a5a-b01b-2e7b0658ae33@suse.cz>
In-Reply-To: <a110ffdb-1e87-4a5a-b01b-2e7b0658ae33@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Oct 2025 17:24:15 -0700
X-Gm-Features: AWmQ_bm8V8LdP4A-G3QXinsd8ut065vtjAkDQw3A14j7is_ar0KxcjD8kryVmlU
Message-ID: <CAADnVQ+8x2b5qddRxU50xeq69XMY5RNi8ZfvTbERidKwTYrzqA@mail.gmail.com>
Subject: Re: [PATCH RFC 12/19] slab: remove the do_slab_free() fastpath
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

On Wed, Oct 29, 2025 at 3:44=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
>
> You mean the one that doesn't go the "if (unlikely(slab !=3D c->slab))" w=
ay?
> Well that unlikely() there might be quite misleading. It will be true whe=
n
> free follows shortly after alloc. If not, c->slab can be exhausted and
> replaced with a new one. Or the process is migrated to another cpu before
> freeing. The probability of slab =3D=3D c->slab staying true drops quickl=
y.
>
> So if your tests were doing frees shortly after alloc, you would be indee=
d
> hitting it reliably, but is it representative?
> However sheaves should work reliably as well too with such a pattern, so =
if
> some real code really does that significantly, it will not regress.

I see. The typical usage of bpf map on the tracing side is
to attach two bpf progs to begin/end of something (like function entry/exit=
),
then map_update() on entry that allocates an element, populate
with data, then consume this data in 2nd bpf prog on exit
that deletes the element.
So alloc/free happen in a quick succession on the same cpu.
This is, of course, just one of use cases, but it was the dominant
one during early days.
