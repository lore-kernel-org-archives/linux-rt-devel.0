Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED603DEAEC
	for <linux-rt-devel@lists.linux.dev>; Fri, 10 Jul 2026 07:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670037; cv=pass; b=PpYn3zNdB6zgLexzpeMLzCMiPMThJTVummcPzo+OuJkuvEZ+POEy+4W+7xCa4JZkvkcWevF7DIKE8yqBqi31pm5bEUa2zeWdBxoEcwPzshjBMGGXxf6wiUTA9EuBZs6HuW1w2zxoOsOmYyMdULseSq9Bwg70TfbX3Be/XK705zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670037; c=relaxed/simple;
	bh=VOWM6CrABsSE1ZgAmtTX+wv+twEBAQ/PjFUZeWerkIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+BduryrIKEFBgdS0ANrzEBRaPbxlz9d6sIP3wQgaFzM7ysxKlSKUvg2Lt24rhXQZASTGW5/NDd6MOIoBMlvT643/t75hMcoR2T2JYtIR0AAiapMRMPDGf9R9atZxM2L4RTZKhU6VfJbkwJckc+3swefwIJj3jn7OH2sDHaJdk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T53cXHAD; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T53cXHAD"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-667971437d6so873392d50.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 10 Jul 2026 00:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783670032; cv=none;
        d=google.com; s=arc-20260327;
        b=bfj5O4OZmjFGA0/TvLGidDP3bXw3wQ1WdY6QYktJRXmF8xVK0PrAQaxKDWDQ9BMBRF
         o1hG8UU97t8ibvVxKh8qnSRdoGp6NAvLSv2P5+gCHWPJakZc6Jspk+x8BIGu3CxrfZNZ
         dRapmU79z0mGl4ZPu6NnsrsNgMefU+tYXTa0ATZfLkgxIdB7DNDSn2OLgBY63KMnztN9
         nprF+ADpXQanftf9FEso27mP34mywolZdZ1Td4hCRHKjIM+3ufqCD0VJCbpYdpWyqTH4
         AJmT4uwcfWSfqqinxjInjiC+3GpsHZDr0oB5zKMiE32wuivL6U/9BcenQU5RNcU9JY3O
         TuSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VOWM6CrABsSE1ZgAmtTX+wv+twEBAQ/PjFUZeWerkIA=;
        fh=wKLlEHvdWbrOtSXX4aKllHlgZ76KH8e5TpSFmoZf/gY=;
        b=r0aL8NJ4VwfTEkRynLpfkUIkvFrUinpWd8eIKpknVdPHKGqORvo+8rfO81DuK02OMS
         +EwBNp6ej5zChh4Njng1a3tbk4f+8ogLPlarkhtITLn2QDfisF/Qy0H1Jrzux07AebSb
         lneXN73m0ovz0U+c+xWPIUnevm5GivkUn+XM7O3U+EQFQO3B0ZX+0vAV3kojC6bMWxTY
         0Kq6WWbff92fjb+csyjIKzV+RY7qByF6EaAmeYgSSfL6lfDJ4icRjBaU5GokVHCWqujZ
         0a12x5Ao508bJAFWlXIuaYXkXKVNbD8i0quBybeQa/kz2EXf/Z9cYn7CvbqOvfmN60J0
         6frQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783670032; x=1784274832; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VOWM6CrABsSE1ZgAmtTX+wv+twEBAQ/PjFUZeWerkIA=;
        b=T53cXHAD/5cE3/3l0XJUHa+pSkaXbl0ZrsAiJJPsCyP/d2wn79xOLhiskNeulpi9Ba
         M1Wwg+MZLZzk/CCAqorRHOYG60ft+RSZUjb7r/rrlGmHB6mrWjfqzyIYfq6lMwBgiSx2
         ozHdDhhO0lnDVQj2zApKNT65DnCiaDz2xCIgjAfc6Zm5pUVJ0Oxn7id0uzf9JqbKCa2Y
         V0TlqtdCJW45HJcIdUH1KAyErrllzAxnZamLUk3uzAInCPTd/TSxgOKPRmGiH4szx7X8
         dngSotnfiZRmJ+kRj4KxSljbj8BxwZ/ODYdkPZMbzUmAV33PuF4nFyBPGMyaqg0JLKW7
         XFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783670032; x=1784274832;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VOWM6CrABsSE1ZgAmtTX+wv+twEBAQ/PjFUZeWerkIA=;
        b=cTjGfq4ssFgM4EKoq531egHIH6m9TRzbaVvzwyHU2clNrnv+PkKfjzEXu1LoCIipwj
         EgkQK2I9PipoHa5m1m6Yo6259BwVoy8hV/t887Hhd/9VCPO+TFDfugzHuZjqFM3hu7yF
         480xjZ3DgrRLlXUT+lTVXApxQ47/cSuLfVHmXYqB4M5/lVp4/YfftRFaKPRMU4b1cK6B
         fFvuLvkvOWgXsFTBvlfaIGtRVWL0oTVNwDfoQyc48gFbJa+JeKSTlhp5c8YSPDOvpsFY
         eSqOT12fcsVIXMfH3ukiLkvSAw1YckwUz7oRa0rg9ClgUak+tKLFwiUx8vmuXTReWzB8
         N17A==
X-Forwarded-Encrypted: i=1; AHgh+RpM9+HFj8KMjoEhNyc082TCavzfJpOFecIgB9HLuFffJPaBsB4ry4r4vJ2v/fCAZGduOV6meqS5SBkzz6KUKw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9/nijRxGndzlDuUX0jF5qIR2dko7omr91SBdhj1ZCwlESH0Dy
	vZVmbmkDWdBAFEXqF4Vy1IoYyDu/mkDaIOBY099FTeeceHqUr/2kjdpooYp/RXoTzMEG6UjQbKW
	Z2MYy1woht1PxEdJ6/7RmB9YIVgB+FJiJ943zIeW3Wg==
X-Gm-Gg: AfdE7cnSHDKKdQ13pWg/QYskYQ7qSgY9Y9Md9dv+DRopDrINAkb8LPnud2oSiBCO531
	QOLIHDyc9fI4kRpYOUP1HjBDpVczj3daWUhj6dgwa/fkLxRbAmUdDLKKleNn4KqUAWwH66W8c6P
	FK+sprn1uvnDdrvbZNuhkCS1PoyrnQz1u8v8FoxpF+Kc9lYHfxGHCVZ7hHbtxHDwU1XKBP09SFa
	Ck3pm2WbW/zzRAOAmwedOItDu1Mu6m0DCbSzIXfsXJkfyRONC2OzP+Sj9yQh1lhDXZ6B5KRKp4c
	eL9zSjR9d/AL99VeJkea62EXHnQpeYClqr44CgV0k8Ijh/2U4onBXPYDUXLqKDJHyhHdxjKuPik
	gWsUqEYS1vxmeauX3/D/I9y/VxnHQ97UVTN9fvay18TckW8XJ2ANY7UW0c4iHurQ0TrJOXNm/QG
	Jckv7dpxyfwMSeREy4yv8jTzckbwsdCXXvdXc9cJwQDnd1J3ZmFDJS/aRO1GaFELzDr9cmXe+tf
	ixYQK9mH/4LdsqXryuOZNM2YLd6qnNDVuk8ErmSHGcCkXo5ArUSrQ+fykhDdaZJYSWQzTFH8Xe6
	G2ZbyRcNYI0qey6Tu6TNwHbcsCbE5ymksuIZZoDO1i3yXSuonFaIdVYv+53SpThfuPJx3jii96Z
	iIxAudg==
X-Received: by 2002:a05:690e:43d4:b0:664:99a3:34a7 with SMTP id
 956f58d0204a3-6679f1ac64amr4926164d50.60.1783670032531; Fri, 10 Jul 2026
 00:53:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260701091226.7SWW4TrT@linutronix.de> <CAC_iWj+xDErhPeKGtsLK=nvPB7P8cQE3g9XCkaWf-d_j85FxCQ@mail.gmail.com>
 <20260710073147.XJAJbIwc@linutronix.de>
In-Reply-To: <20260710073147.XJAJbIwc@linutronix.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 10 Jul 2026 10:53:16 +0300
X-Gm-Features: AVVi8CfEoTWISJnCnc9-eLJA2a3H9SubdRhk1-OoqodnM6Xg_e0TDYWFCpSokGU
Message-ID: <CAC_iWjLO3CAAFXE3s15Xcy3pWFK3ge5sWYmHHRBtcccKM2e1hw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Extend the real-time hardware bits with
 some firmware bits
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "jenswi@kernel.org" <jenswi@kernel.org>, linux-rt-devel@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, Ard Biesheuvel <ardb@kernel.org>, 
	Clark Williams <clrkwllms@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Jul 2026 at 10:31, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-07-10 09:29:55 [+0300], Ilias Apalodimas wrote:
> > Hi Sebastian!
> Hi Ilias,
>
> > > +++ b/Documentation/core-api/real-time/hardware.rst
> > > @@ -130,3 +130,95 @@ https://github.com/Linutronix/RTC-Testbench.
> >
> > [...]
> >
> > > +
> > > +OP-TEE (ARM)
> > > +~~~~~~~~~~~~
> >
> > That's RISC-V as well nowadays
>
> I did not find much here. Their architecture isn't the same as on ARM is
> it? But the overall concept is the same, right?

I haven't checked the IRQ vectors on risc-v, but I assume they have a
similar logic since that's an OP-TEE design decision not a per
architecture one.

>
> > > +
> > > +OP=E2=80=91TEE uses a global serialization mechanism (the "big lock"=
), ensuring that on
> > > +each core only one OP=E2=80=91TEE thread executes secure=E2=80=91wor=
ld code at a time.
> > > +
> > > +Execution flows from the normal world (Linux) into the secure world =
(OP=E2=80=91TEE)
> > > +through the secure monitor at EL3. Linux and OP=E2=80=91TEE cannot d=
isable or mask each
> > > +other=E2=80=99s interrupts because both run at EL1 in different secu=
rity states.
> >
> > That's not always true. It depends on a combination of OP-TEE and TF-A
> > configs iirc.
> > The most common though is that IRQs and FIQs are directly delivered to
> > S-EL1, in which case OP-TEE can mask IRQs.
> > There's also a difference between GICv2 and GICv3 in the way
> > interrupts are delivered.
>
> You are saying that OP-TEE can mask Linux' interrupts or if OP-TEE
> instructs TF-A to do so (via config)?

OP-TEE can mask Linux IRQs

>
> > > +
> > > +Architecturally, the secure monitor can mask or reroute normal=E2=80=
=91world interrupts
> > > +before entering the secure world. In a correct OP=E2=80=91TEE/ TF=E2=
=80=91A implementation, it
> > > +does not do this for the duration of secure calls. Normal=E2=80=91wo=
rld interrupts
> > > +remain deliverable, and a normal=E2=80=91world IRQ will preempt OP=
=E2=80=91TEE via EL3 and
> > > +return control to Linux.
> >
> > The 'sane' case is indeed where IRQs are delivered to OP-TEE which
> > exits back to Linux immediately.
> >
> > > +
> > > +Secure=E2=80=91world interrupts (FIQs) are possible if the SoC route=
s a device's
> > > +interrupt as secure. Such a secure FIQ will preempt Linux immediatel=
y, trap
> > > +into EL3, and transfer control to OP=E2=80=91TEE's secure interrupt =
handler. Linux
> > > +cannot mask or preempt this. Secure FIQ handlers must therefore be e=
xtremely
> > > +short to avoid introducing noticeable latency.
> >
> > There are also 'fast SMCs', which run with IRQs disabled for their
> > entire duration.
>
> can their be distinguished somehow from normal SMC invocations or is
> just a consequence that the secure monitor does not enable interrupts
> during transition for some of the "functions"?

They can be identified. There's a function identifier defined in the
SMC calling conventions doc [0].
Bit 31 is always 1 for fast calls and 0 for yielding.

>
> > > +
> > > +The transition from normal world -> secure monitor -> OP=E2=80=91TEE=
 and back introduces
> > > +additional latency due to world switching and context save/ restore.=
 This
> > > +overhead is typically a few microseconds and usually remains in the =
noise
> > > +floor.
> >
> > That's correct.
> >
> > > +
> > > +If the secure monitor masks normal=E2=80=91world interrupts during O=
P=E2=80=91TEE invocations,
> > > +or if OP=E2=80=91TEE uses long=E2=80=91running secure FIQ handlers, =
then OP=E2=80=91TEE can introduce
> > > +measurable latency spikes.
> > > --
> > > 2.53.0
> > >
> >
> > Overall I think this is worth documenting, but infortunately there's a
> > wider range of configs and corner cases we have to describe.
>
> Okay.

[0] https://developer.arm.com/documentation/den0028/h/?lang=3Den

Cheers
/Ilias
>
> > Cheers
> > /Ilias
>
> Sebastian
