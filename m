Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8F0248F78
	for <linux-rt-devel@lists.linux.dev>; Thu, 10 Jul 2025 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158500; cv=none; b=ecNUpA5a27kVV6P9micuhjsqxpcXjCA5oFoaK7mgIJZf7YZakmsvp69Fr2JNvBezbjyHYmGz7OWEr2TfdbgRb/755U/5QqR73zz9MIR9WsF9ETkLTUCmm+rpewmgf5K4bCLzuFhu6mGod/6WoDKDtxltmIevtvmz4httBRO5yVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158500; c=relaxed/simple;
	bh=rTCP0eFlUYf1cAy9AjZjkIhxqdiUY75FHK6S4X4wtU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVmlcO9jpZ7z99Ua/SkTMfeXHeQ4exA8l+jNX3yZMIWaet5jdfX89JukIqfAdJV8nVq7Wof+ev9+bMSJy0S0yg/f2bYc3maoz003eCoRF8DJFz264bmS/6IMd+oQc5cmWVDjp3z2/FHoclrRE/PV/iyHAmsjThpXi1DdKJfpbH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C37HOU3j; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C37HOU3j"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-710f39f5cb9so10393887b3.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 10 Jul 2025 07:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752158496; x=1752763296; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlZgkHsxN8ZXtcGrfVzgc7A5zah0HXAJABQ2cFxyfyc=;
        b=C37HOU3jlcg9aP+69wzLxOyVOgmyzbVBCf0+5QnmRzXz63N0asCMIaEn73IIPpeW45
         +p3lUkcwHs90+zGjBlm+rhveW93n4ByH/BIzG6pS1qnDsoNMXq6VMgpAzT78Ly7tCpQQ
         Svq3Tf36pFAtW8flEKG1Ca567bcAaqCzioWVuwq4x0gU1yENVcLtJdqi1BrIwvdtNr29
         jv8Sx/pg2q6O4W9wkWMINQOjYGZgbxcTzRzgFM6KuaxMLcB8ojt2XDo8JuV4cYCPXqgy
         VO9hytDGYEKSgARav70ABlOsXe7VjqNhB1ZGC5KqxY8CBJ+5BEjPLYDKChGwSrt7F74N
         z0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752158496; x=1752763296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlZgkHsxN8ZXtcGrfVzgc7A5zah0HXAJABQ2cFxyfyc=;
        b=dHO1DgykvmYe6mmFy89CoFCnkexuLkMEYiS793UjLwiDwWhkvXEmA2oyOBLoIYaJtZ
         q13EoMq8EOOxSiTrJlYS/DXBYJ5RatPEXIoWc6DjBcuUZqxk5TrEDH4NyKjIIINwGIAS
         Fz74+zEt8m8NhSSQnuDpaBIZX0bYiTIWK/t3U6WjUvGA1oYgAn3vZMNQvuTC9vwh8QJh
         nnn8SWqGxlicGkmNoDBJD88LK6SOUIMd/M6ri0vrAsaxgAwytbvam8OmmGdF9NJkRz1d
         seKGRK0PoyprfpTYCOwXuxQIrTcUbMtHaNhj1oQiQ2YigOLvu9FoyQcyJOWgoP/fraRe
         Jtrg==
X-Forwarded-Encrypted: i=1; AJvYcCUMhi6uS6iWm2/ZLG9hFkxz+MI/NGw65kgvbK12vm6rETNF5GXyvEVz8+OY8+DFkC3sDXf9u0oEdYibHyDthg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWqRiVwGZORxoEFMKSQSSZvmyW5zJiVumODNK61ygM7cnywl/Q
	3QR4/VcucAZZgI25aDR73vQVlGFHYgjwN61z7rPytF2xrcaWeJHs4HvTS9mTyI6cq+Ifzq1euZv
	XZhr/sMQJMZAF5/yA6GOZHbZn5kR4GgXaENWqOx2Yag==
X-Gm-Gg: ASbGncvuPbTnGvGjyATJWJjLZBZ4Fu+LswBvZLPTr/swZEojrtuY+qpdpkTigRwvijC
	9URwpn6YcopK/fUQTWVM6gE4sfEbN7VkSl0q04K4Xly2krD1ymG/vz8feo9PQURJlgd8dksfTDJ
	o6c2V2NB+xnze9pYOISc3sP+hWxyeDU3boFZs91FsLASE=
X-Google-Smtp-Source: AGHT+IHVD6gPsHq+Dexvu9tOsagl+k20PpDSEAg/CCtZ6R9oh9y4FIYINC4cgMj3d0zJYPGC/y7DQa6nR8qkXx9Q06g=
X-Received: by 2002:a05:690c:d90:b0:6fb:b8a1:d3bb with SMTP id
 00721157ae682-717b19cb233mr100039137b3.17.1752158495634; Thu, 10 Jul 2025
 07:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250709154728.733920-1-daniel.lezcano@linaro.org>
 <CAJZ5v0ixk5hZPPQc_1rDLMTzjh=KpMQF_A2U=HehMTuNSMQwtQ@mail.gmail.com> <aG-40INpi05v3-fQ@bogus>
In-Reply-To: <aG-40INpi05v3-fQ@bogus>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 10 Jul 2025 16:40:59 +0200
X-Gm-Features: Ac12FXw291rGaeQnkKGBJOE99wWaDDVeGF-LGyRZrV90PjOPwqUc_kzJDb-fgDQ
Message-ID: <CAPDyKFqS9fawvgxEhk9W=o3oUpA_HGc71-5siw8AGqenQegrLA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Fix cpuhotplug routine with PREEMPT_RT=y
To: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	linux-rt-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Raghavendra Kakarla <quic_rkakarla@quicinc.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	"open list:Real-time Linux (PREEMPT_RT)" <linux-rt-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Jul 2025 at 14:57, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Jul 10, 2025 at 02:43:10PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jul 9, 2025 at 5:47=E2=80=AFPM Daniel Lezcano <daniel.lezcano@l=
inaro.org> wrote:
> > >
> > > Currently cpu hotplug with the PREEMPT_RT option set in the kernel is
> > > not supported because the underlying generic power domain functions
> > > used in the cpu hotplug callbacks are incompatible from a lock point
> > > of view. This situation prevents the suspend to idle to reach the
> > > deepest idle state for the "cluster" as identified in the
> > > undermentioned commit.
> > >
> > > Use the compatible ones when PREEMPT_RT is enabled and remove the
> > > boolean disabling the hotplug callbacks with this option.
> > >
> > > With this change the platform can reach the deepest idle state
> > > allowing at suspend time to consume less power.
> > >
> > > Tested-on Lenovo T14s with the following script:
> > >
> > > echo 0 > /sys/devices/system/cpu/cpu3/online
> > > BEFORE=3D$(cat /sys/kernel/debug/pm_genpd/power-domain-cpu-cluster0/i=
dle_states | grep S0 | awk '{ print $3 }') ;
> > > rtcwake -s 1 -m mem;
> > > AFTER=3D$(cat /sys/kernel/debug/pm_genpd/power-domain-cpu-cluster0/id=
le_states | grep S0 | awk '{ print $3 }');
> > > if [ $BEFORE -lt $AFTER ]; then
> > >     echo "Test successful"
> > > else
> > >     echo "Test failed"
> > > fi
> > > echo 1 > /sys/devices/system/cpu/cpu3/online
> > >
> > > Fixes: 1c4b2932bd62 ("cpuidle: psci: Enable the hierarchical topology=
 for s2idle on PREEMPT_RT")
> > > Cc: Raghavendra Kakarla <quic_rkakarla@quicinc.com>
> > > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >
> > As per MAINTAINERS, this is for Ulf/Sudeep.
> >
>
> LGTM, so
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>
> I still prefer to hear from Ulf who has more knowledge and hands-on exper=
ience
> with s2idle + PREEMPT_RT in case I am missing something.

Rafael, Sudeep,

I will pick this patch via my pmdomain tree, but will run some tests
of it first to be sure.

Kind regards
Uffe
