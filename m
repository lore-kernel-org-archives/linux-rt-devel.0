Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7986F23392B
	for <linux-rt-devel@lists.linux.dev>; Fri, 10 Jul 2026 06:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783665035; cv=pass; b=NgDC5kFD9J6d00FMjEOG9C/nXBudpdb4QjrvCxcIPs1FWUiW7cO2aux2vRw0jial+q7JPnDjLcLvmCIu7YedR5WPb/PWp5XUKpQ8V+NColzEvqvFuignNq4YkmJ0UEYAt0Te4ciM5R41spc3ty7rY2Gb0qudVZkPnIHPDihmp5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783665035; c=relaxed/simple;
	bh=6X4b53rZef1KKZD4TQJDBFQHHBhHup5eeeap5U4K8mM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kd/yzYDa4dNJfaOfW3dL9ynYeIraHDu7FBWQqiRDKK0JskP1EmsMzNSB8PEngZix+0K04V1RVgNQwNCFVG8zhsyBJTz6+dSsJk7qJIV4gM27B+ls7Wt01/4e++ysdGvNVucpBsIsa28K1OWW8bl6P63NPhMW/vbFpjw522zojpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qGc+NuAE; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qGc+NuAE"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66493875766so1009395d50.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 09 Jul 2026 23:30:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783665031; cv=none;
        d=google.com; s=arc-20260327;
        b=lgkyoyOPN1bvP4OkZiZR9dW4gDBpk7S1rXGTe+gWtXoNQNLSS7PBSUwnO+pFZcADsF
         +oCWw0P2VaM+USzWzJBHqjzMb1MWHRQusGT2ztJO6lbc9wEPKeRQb4Bsbs8PluGF6CdV
         WSFa5eQBwDr0Q5VZNBzZw+DsyGlxTZF2qniZ3efSk6NZo8Qgv5KSWajeyyvXs9Gj90+O
         ui7HilGEsPhHr4k5mfPJOsxM72fH/bVNNJ37D+fjv6dm4HzlUlnNNyS6rKnYb7yzyuFF
         mCKtWsKOc99dYcokK1wROHXbmla2v9i6KH9G7dmYbHxY1SZEbmHZsnDKRWEupnpaM3eW
         3WNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZT819g/Oq6qSvxizAhqmr/HnAVYEmomTbXe1mM2C/vA=;
        fh=3EM//Sh09se5QXq9XlYfHBis6CqD21ALsV6zk3qbvHY=;
        b=MNH5tmDTvbyhIlsVSVzlRTBfnHMlGppwhsMPwQvakh90SOVe7oPfr5Gkx9DuKhqIIZ
         JhNnvalkN1yj0YLk8K+0sN77GEJS8xYXa9j82HxF+EBMWDzUWPTCX2YYx8wmb9kB1vWi
         GlBI2PuSlt/PPr9TXeT6WqxLso/qBsj8foMHkIatnLjznMDR32fR3f7i2EoVr7xtuBRT
         ulGAhrPRZmVLjoq1/ELyFEuxhgZKOyyW/8dMDtsP3mz2R3PhGgG1cTL3kbq+Di/FdZg9
         BVDUczATAq1SrnGXYZw1hRlCNoiAc63GDOwP7ZdIThkHZHNBIDs6Una9bEHoodNsOILT
         fYlA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783665031; x=1784269831; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZT819g/Oq6qSvxizAhqmr/HnAVYEmomTbXe1mM2C/vA=;
        b=qGc+NuAE2VTTlePs9ozasdlAvvPTYdVtPRj5iQ3mi05/06qBZ5jGe8F2Z2W8wqVLmD
         QLjSnPPYAAzIOjJ+ZVGdsBNHuX4PqR9y8wgFIM1SzGRFUrmjUQ5LxvmHN1b0r2eF5rnA
         4ZJTmHBIGMBAJnvIjkNHda2j0D8p2+S6Cgmp0O4iAvU/PcUZTzTjpLUuj1WGgUknWA8Q
         PKaa8sD6mVe6jhkBZnnCBUram5ajls8SWXmjzeusT/zp9jESQ+aeyUS9aWsQ+MLHjec8
         lPBv6DhhUSwC5YkOqBBo9ohJqG0XYKH2ULDKuYpECHeIdS3bhe6BC5aYL7quDmF4wGze
         hWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783665031; x=1784269831;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZT819g/Oq6qSvxizAhqmr/HnAVYEmomTbXe1mM2C/vA=;
        b=cX8/W2ITvWlZQYrZxamA/vqW8RwCm6mZzctZbNa7JjH37B4PfUWuFTbxkCSt3ICzu0
         Ub2MLCsn2kXESL7TzAVoGBDEcyZMC3wZ043d/bvXobK9DIL3v8lNJtYu5x6CfTI1tj51
         M1O5Yy+yv4iseKfLq7LAq0DMyLveXUsSQYHEVe0SDIS5GED+eD9vg+bKSE7WrTHrC5Ov
         yZZgzipv1szGTdax33NTSQZI+/1aQmegwlPmEePzDSUsP1zVGB0VBkx2tRqGZale1axq
         stabknYEsWQhmqRztbTIhnp34g0SCS+QtQm4xPwe45VYqBvkOeNT4mUrLgEHUPop34ey
         r8UQ==
X-Gm-Message-State: AOJu0YwlL8XM453r1PzgoKVXBLueRUz3ZE3Gq6OOqcPVR0ypHQraXNcR
	pKa3vg2H6hdyeReeS4sbLAMhBFpVH72/9viG0f+JhLuUglDqmmpt0WUyYgMKx2rfCz4dWEXNQFt
	N8g8SQbbI+vU0j0FjmD/rpLiRoPX0RF4jbuuMEtOSSg==
X-Gm-Gg: AfdE7ckgA3L6rbzbIjnmVpMYpyEpvRzU515MP9VbyiLdVYP3iJrC7eEm2D/OdrZ01eO
	MX4zzjpDbq9Ayy5i61fNVMgvsBDWNyWKJlZ81mCSPv8IGtnZd1cqH1Yl1pjP0J2bYcgJUN0Ub4+
	2Li/DMKjeKCnSyL20qV3RqiLmMcuGcaylqQYhQ9zpl4kRma8of0f31/9rFoitDALDq07Ib6nmne
	bc02PNtLgkIiIw0nXyTI+ZR3acBOofnrRJ6KEFlHfxqWnmILDXF1ztHqFQPv6oUP2fMAuGPuKFU
	7ydGNiWyfJQt49svkYEUBo8DAKU8ZnjQzX3PifymolMYKKW1Y7WvXpccm6IG2Q52jNxyM8M6B05
	tWR6UIs7Mh+dR3ww5PdIVidqYjL8rHQL2DqzyzyjWDWwTELUOoQ8PYmxTHKx6O+rF7mnmDwb/Ex
	4wqYYjqNUv+rBJolMR7r4N0B6zgWs8n2GLBaN7lULZS8PON7sKonvDMOdER9oy0xH38f6XF9VSk
	Led/v0axx0U3OK+1W1OZ9dYYo39sCoMHcFwhY81v0pAXj/AHly/RcZafYNLkkV7ZCBjM9oHa1cR
	SNE1Q+nWAi0S1IyBoKTsdzE4E1gv+8rgnv5UKdoW4iBQaqTFLwlqdRQaYBBcX+Pe1jR2nlg=
X-Received: by 2002:a05:690e:1609:b0:667:9eb2:8ffd with SMTP id
 956f58d0204a3-6679f25cc74mr4981051d50.90.1783665031305; Thu, 09 Jul 2026
 23:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260701091226.7SWW4TrT@linutronix.de>
In-Reply-To: <20260701091226.7SWW4TrT@linutronix.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 10 Jul 2026 09:29:55 +0300
X-Gm-Features: AUfX_mxLJVuqDQuycLYMMiskfwdItuud7PupTjy9MFHq6Q3HmuV1dekuQzstXtk
Message-ID: <CAC_iWj+xDErhPeKGtsLK=nvPB7P8cQE3g9XCkaWf-d_j85FxCQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Extend the real-time hardware bits with
 some firmware bits
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "jenswi@kernel.org" <jenswi@kernel.org>
Cc: linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	Ard Biesheuvel <ardb@kernel.org>, Clark Williams <clrkwllms@kernel.org>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sebastian!

I'll let Jens fill in the gaps. Some general comments below.

On Wed, 1 Jul 2026 at 12:12, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> I have been reviewing how OP=E2=80=91TEE is implemented and how secure=E2=
=80=91world
> invocations behave. The goal was to determine whether an OP=E2=80=91TEE c=
all can
> delay the Linux side and introduce latency depending on the time spent
> in the secure world.
>
> Similar latency effects are already known for EFI runtime services, but
> this was not documented. To mitigate the impact, EFI runtime invocations
> can be restricted to specific CPUs so that real=E2=80=91time workloads on=
 other
> CPUs remain unaffected. This mechanism, however, is only described in
> the commit that introduced it.
>
> This change adds a firmware section that documents these behaviours
> explicitly. It highlights cases where firmware can delay the kernel,
> information that may be unfamiliar to some users and surprising-or
> concerning-to others.
>
> Assisted-by: Microsoft-Copilot
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>
> I would appreciate an ACK from the OP-TEE camp that I got my little
> research right.
>
>  Documentation/core-api/real-time/hardware.rst | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>
> diff --git a/Documentation/core-api/real-time/hardware.rst b/Documentatio=
n/core-api/real-time/hardware.rst
> index 19f9bb3786e03..fb113848c2f70 100644
> --- a/Documentation/core-api/real-time/hardware.rst
> +++ b/Documentation/core-api/real-time/hardware.rst
> @@ -130,3 +130,95 @@ https://github.com/Linutronix/RTC-Testbench.

[...]

> +
> +OP-TEE (ARM)
> +~~~~~~~~~~~~

That's RISC-V as well nowadays

> +
> +OP=E2=80=91TEE uses a global serialization mechanism (the "big lock"), e=
nsuring that on
> +each core only one OP=E2=80=91TEE thread executes secure=E2=80=91world c=
ode at a time.
> +
> +Execution flows from the normal world (Linux) into the secure world (OP=
=E2=80=91TEE)
> +through the secure monitor at EL3. Linux and OP=E2=80=91TEE cannot disab=
le or mask each
> +other=E2=80=99s interrupts because both run at EL1 in different security=
 states.

That's not always true. It depends on a combination of OP-TEE and TF-A
configs iirc.
The most common though is that IRQs and FIQs are directly delivered to
S-EL1, in which case OP-TEE can mask IRQs.
There's also a difference between GICv2 and GICv3 in the way
interrupts are delivered.

> +
> +Architecturally, the secure monitor can mask or reroute normal=E2=80=91w=
orld interrupts
> +before entering the secure world. In a correct OP=E2=80=91TEE/ TF=E2=80=
=91A implementation, it
> +does not do this for the duration of secure calls. Normal=E2=80=91world =
interrupts
> +remain deliverable, and a normal=E2=80=91world IRQ will preempt OP=E2=80=
=91TEE via EL3 and
> +return control to Linux.

The 'sane' case is indeed where IRQs are delivered to OP-TEE which
exits back to Linux immediately.

> +
> +Secure=E2=80=91world interrupts (FIQs) are possible if the SoC routes a =
device's
> +interrupt as secure. Such a secure FIQ will preempt Linux immediately, t=
rap
> +into EL3, and transfer control to OP=E2=80=91TEE's secure interrupt hand=
ler. Linux
> +cannot mask or preempt this. Secure FIQ handlers must therefore be extre=
mely
> +short to avoid introducing noticeable latency.

There are also 'fast SMCs', which run with IRQs disabled for their
entire duration.

> +
> +The transition from normal world -> secure monitor -> OP=E2=80=91TEE and=
 back introduces
> +additional latency due to world switching and context save/ restore. Thi=
s
> +overhead is typically a few microseconds and usually remains in the nois=
e
> +floor.

That's correct.

> +
> +If the secure monitor masks normal=E2=80=91world interrupts during OP=E2=
=80=91TEE invocations,
> +or if OP=E2=80=91TEE uses long=E2=80=91running secure FIQ handlers, then=
 OP=E2=80=91TEE can introduce
> +measurable latency spikes.
> --
> 2.53.0
>

Overall I think this is worth documenting, but infortunately there's a
wider range of configs and corner cases we have to describe.

Cheers
/Ilias
