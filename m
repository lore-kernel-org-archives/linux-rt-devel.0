Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964B061FCE
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Feb 2026 06:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770964150; cv=pass; b=dciRTOZ0rKm7IA59jQI9qc8tm6ie7LMXw9irPSy/VZEelsrKoROx0/3Hq+X82Wt9eg/MjFVzSm/+9tl+LLlZgbU8gHvGPrt/K4OqgXiFdmFha27DOFVhim1Qx9/yAITHynDiyigj2ieIbQXoZPJGx3PS0AegvDElc4yGidCipVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770964150; c=relaxed/simple;
	bh=XWIo7Hql1rN4HTTpvN2E3D+/ne/cOcRvwlJjqBedbgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqtCcsPYeHjzyaFuX22aKlLCynMroro4mEYxGloyYUZU0UMI5QKhgS17ATQYDKbljoEaw2/139fgUK82w4wpVwO+5t+78m7g86bG7ay1bOjNISM4sVu4Sg4ODlSvNV53b2Hej+Bd12NVo1yDGFeT5vLL1FmqTadqeF6RhTAIm8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WSoV3TSW; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WSoV3TSW"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ae5f0777dso610682d50.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 12 Feb 2026 22:29:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770964147; cv=none;
        d=google.com; s=arc-20240605;
        b=ObTVIMn/RiTJNo81qSKZm1t0CX05nS6K1JhYLecYuKy5/O2F33hpiPsmtLXQL/2G5r
         GiCfvWAbwHqIRQJvaGnHSWRIiU0HLH+BJQtZZS8MaEhrPWTxoVg6FK5x8wrHjKYJMFWb
         0v81azwSQq4eQgwbDDK6wG/wOoukXIZlAcsy1SrkoHGWQncP6gKBGQirfI12swuJPXwf
         KJANvAJvHiyrlB+e9ar/AmLV96HmCp2mf6IOun6BwaS9UdEUWuDvUkx4KcTP3R4f36Lp
         FpZDRJE9EfyxfgKgH0XsbdKaSAqE8P74VbAFjuJtV91jdC6N2Ghhorh4WLjp9ljY2eRe
         GIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tQVFLn5cPaqooiNQTL+EbKOr/AUzqPPLp1PwWo0P8HE=;
        fh=rs8iolUthd7MWSlzzvYdc2Udc2ao9kDTsPirBXQXf1g=;
        b=WN/ZxMXRQRQCQgr2bGcUVxn7UIJzgbnTsA/D+THbVqEdhClNj7p4SruE/hwhAWS1sj
         oe3uJ+bNVuEpBA8zQwNePzJUnqiX9RT6J98hQiowHMFFZVfXqIhZ0DFTN+eyMnuqTrgV
         t1EYkQsJDYQV0GWNc2zx6R6m2oqS3q+JO/e7R7wOFcXsgU/9tGkU4Rf0jezp2yHSBwfX
         byAN7Ox1pLMMu3uVJ06BVGT2iS1XRSpNJgKikJ2ilF+35LadW2Umd8vboJv/m04KjjKx
         YSKAB4klft7GIFrEPxe6tEEzN7IHKRfsG2tekKZVY/kV6MQFE9QIFVs2haNTYqZ6fiwG
         lyrQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770964147; x=1771568947; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tQVFLn5cPaqooiNQTL+EbKOr/AUzqPPLp1PwWo0P8HE=;
        b=WSoV3TSWwcCNa4QH0d/EyQviAOwsMHGImcr3wIMu9urqe9wrdtGktWbRBMBJVxt0Iz
         p9a6qpe0OjTxvWJztkgsVxSH1qciaMUUH5MtyFtZfa8NKkkmnFQGHhads5bOGfCW7HRO
         WtKe20/Kv9WJ5/xC9+Ps3eNYi818d7FhpLCteQqgSXjfDIvF7w3QV+o/lQMRG6TRDkhR
         F0UaqwxbMh8YhEYSGvlnz9rKVBuuSkz5aPR1PigDzcg84GDttJ5Giw+KlFnedpjOw1UJ
         +wgfLmpiQAdYkpookt/Xme7FQnYC3Qg8cw8CbHtP+3lJwK2DBgdZyqtJU+CDd0F8xf9s
         PBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770964147; x=1771568947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQVFLn5cPaqooiNQTL+EbKOr/AUzqPPLp1PwWo0P8HE=;
        b=HEg9XHlQp4yaUw5nPqVcG/gOv6+y3cUdDFr1XjQUH84DjseBCdD6YNiqQfCK/XqHfO
         BRcMf0RLWAvP1PqcI87Q6JfcK5zT/0SDzdEaCtF3kuXrn7LF6Xev30UgW9qiq8Lbvxmd
         r1ZjtuwEkoFnvYbWYZKkOBxWiSlcG83Tvg2tYKDfjCZcrg4NWQ3fArs7vBZzhrcyyMpb
         JLfd6b3/flM7ZYyqp73blISm3BZSMOlFhS3b9S2a/X8tZV//Izv1gMQ57aJmBN6rsOlQ
         wpQckQy84ggH70XpeEj07ytQLRY7I8BuBcVvTarB5baVy4iCfezdulKR3UTEmcOTqqcE
         r7IA==
X-Forwarded-Encrypted: i=1; AJvYcCUZvh1OoF3tGXECTPxbCJUzADMHBvP9wck0AQ7KWU4ckCTWtHd0WBYjhrvi4fonI5vsVBg2RAQQ9T2e9KbQNw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWn9FvWX8exSx9T44Qs0R8qzfFq1kX6SjDAdNWKCRC8CvOvQcD
	JYObEcZad3BVFtbgUaav/C0AOIsi1BeEpzUKUBijthAUtpBfSuSB3QUU+qvcp5WQ759Lm+0p7+f
	8cS7VzjQvvppwoGeAjsKEl6njEY0uwdW6Y4j0F82BfQ==
X-Gm-Gg: AZuq6aKkTl6TuDbH83m+QFUidknTO1asXfyvDwMx+qdrFgN1Cgm2Jibv5mz1Tg+iYpn
	vzGc3tjCDYk4Ll1VOYk4UVzCYJ9opcCXAsncTm3YYxdyXIQ6uBwTRgt3yJV0gm5vgOQWwWHdiST
	gUJOGbrkpwPj9qVUCzYjnXNuLb44SlXU0LYeuFGVXNmbhBjf6FraHmHgvNK837cmKZTZ/Ssi2lR
	KqBCSRvhcwSyQsDxqP7SCXENQ7xZouyUNQEV5H4GQF26F9NtZk4MqnxBI9HP5rcwCVMgyKqFHgj
	3V4mE3EeI4jv0xO0n9/pFXtlMfxZRr63m6ev1nzmv0Hog9XnSwNl82JKzP/oOCXGwSIi2hMobCx
	fx5SeQCwWCEDoOFXzc+YwO4UpC+G8ljmG85Nx4kB9P47hhzWLp0Djp7z2pRBafMAbyFpoNj+zbl
	evXPu6JfvgZMepJcUi/zP6yMbeL/XB0rz6OEBvLaHg+zL/nfIFXR0B9eRWnV72KO8LppDFwUn7N
	8u+PJ01QwHOye+hhO2OBVm3mixYmrwLV7BvQgKXPcqpALp/x+QYaUHvenaSaN1/HmbcMF9DltCF
	DtUEsdXlnXFzPrQHlW5L3zPGqKrAgF3F0G4A9DYUMIPp
X-Received: by 2002:a05:690c:4d89:b0:794:ef94:1222 with SMTP id
 00721157ae682-797a0cd07e3mr12753437b3.55.1770964147537; Thu, 12 Feb 2026
 22:29:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260205115559.1625236-1-bigeasy@linutronix.de>
 <aYn6j_JLBENcY96V@redhat.com> <20260209155528.k7RMRPVD@linutronix.de>
 <CAC_iWjLt-CzTkmnVMHidnMFWkE9NPzVLo6g8FUgMu0gAUJ0KtQ@mail.gmail.com> <20260212162041.acU_rljT@linutronix.de>
In-Reply-To: <20260212162041.acU_rljT@linutronix.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Feb 2026 08:28:31 +0200
X-Gm-Features: AZwV_QhwAzoy29uRON-C54jYvitJkKlgh7E9kmWTIvcPHuioNdqkhk0IAgKbCXA
Message-ID: <CAC_iWjJL3Ng=+QH2pBCLskE1aiSJJJM1Db8JU+UGNdKsrLYhZQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] efi: Expose the runtime-services workqueue via sysfs
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Ard Biesheuvel <ardb@kernel.org>, John Ogness <john.ogness@linutronix.de>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Sebastian,

On Thu, 12 Feb 2026 at 18:20, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-02-12 09:09:51 [+0200], Ilias Apalodimas wrote:
> > Hi Sebastian,
> Hi Ilias,
>
> > Late to the party but ...
>
> glad to have you.
>
> > On Mon, 9 Feb 2026 at 17:55, Sebastian Andrzej Siewior
> > > What I don't know is if this is a problem, i.e. is it possible to
> > > interrupt the secure monitor and continue in Linux before heading back
> > > to the secure environment or not.
> >
> > In theory yes. In practice, at least for arm & OP-TEE, the
> > communication between the TEE and the secure-world app doing the
> > variable chekcs & authentication is via the MM protocol [0].
> > IIRC that requires to run to completion. So what happens is that you
> > enter OP-TEE and right before the StMM is invoked (the app that
> > handles EFI variables) all exceptions are masked and it must run to
> > completion.
> > The period of masking does not include writing the variables to
> > storage. That's handled differently and is interruptible.
>
> There it RTC and variables which is the most common thing. If you can
> somehow outsource variable read/ write then fine but I guess you need to
> wait somehow to ensure the data is written. Anyway.
>

Yes the variables are processed with exceptions disabled, but the
actual writing to the RPMB runs as OP-TEE RPCs(remote procedure calls)
which can be interrupted.

> That referenced document describes the protocol but not the
> implementation of how communication works. What I found is that most
> interfaces in the TEE world end up either in "SMCCC_1_2 hvc" or
> "SMCCC_1_2 smc". The smc command in terms of arguments is described in
>         https://documentation-service.arm.com/static/5f8ea482f86e16515cdbe3c6
>
> but it does not say if the interrupts are masked.

It's a bit cryptic indeed. It doesn't specifically mandate it, but the
chapter 2 introduction says
"A description of how MM services can be invoked asynchronously is
beyond the scope of this specification". So we tend to keep them
disabled. But as i said I am pretty sure keeping them enabled, if
needed, won't break anything.

> I would assume that it
> transfers the execution control to the secure monitor which is then
> entered with disabled interrupts similar to an exception on the linux
> side. In that case it would mandate a workqueue kind of solution so it
> can be pinned to a CPU.

We enter OP-TEE with exceptions is enabled. It's only when we enter
the S-EL0 application that processes the variables we mask exceptions
[0].

>
> The only exception here seems to be the amdtee driver
> (psp_tee_process_cmd()) which sends a command and waits for an answer.
>
> Sebastian

[0] https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/kernel/stmm_sp.c#L124

Regards
/Ilias
