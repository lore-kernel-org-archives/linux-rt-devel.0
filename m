Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C067E185924;
	Fri, 15 Nov 2024 06:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653109; cv=none; b=os7jnCWHFNKQj1hTRCmRrZG8WcccUEeXHg2bajwrZ992g5aEAycwvd67ikXkI+GdSJEUXHyR0Q20I1oMbaiT6RyJeOlAgcGpZv/kyXBhzF7HWzUwdlvpsOpClJdJhF9EALnltPtI7H1QP4e6DNYRF3f2EiNlO+tOHDXBjXvqMps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653109; c=relaxed/simple;
	bh=uVcm7BxxoK7H3Kj7VhY4WsbhXXCZRM5oZCkE3o6Mhuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhrK7PDMk2kvDhlUvtefvLgzk0jtctnJXqxfKbrJ8X+OvmFc9GsaiFw5GcN9JYpPzqPFrDLVSbxE2bJIOHqmp1S/wRFEzzrHU3jTqfxLO+I54NTDJ50jrtpRnhoOcQnqZbtG9vFML2pZUShmja5g79+/rinad7DuqHx8tmAkjm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTOP/ajm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTOP/ajm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAFEC4AF0B;
	Fri, 15 Nov 2024 06:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731653109;
	bh=uVcm7BxxoK7H3Kj7VhY4WsbhXXCZRM5oZCkE3o6Mhuk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aTOP/ajmdC2zqBtkFAHyU+FXiiE/dxpOvjSZ0YBF0tWHinQTC/ueAY+onRh9Zfjtz
	 h5cI0gQYr99zbP/AipK4yDwO2ZLdmUzyiv346DOs6AGsIlZRaiYSX7Kkz9hUjsfk++
	 SCBV13T/VG8Sg2GcOV774LJT462Y1jPLdfmiKN060mDFPqnD1CryMZp0QyZoUBcrL/
	 28Yrg7unBkGddf7Q+8uhW14WnoKcTvcxFDtEDAoPDSvHwvG6Xr1jjhT84oFFBtMmBy
	 h6gGrji5OokbyPgqVoLZYg/W0fuFkzycXWZ9euA1HQyfoOw8tE7R8sB1mJJQllqs/B
	 DxA/FGLcp5l3A==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so240423066b.0;
        Thu, 14 Nov 2024 22:45:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGhOtQwEeVbYzJTaNZX37l1e3qMRRjZyDZB2sN4YsA94Vs97McPR1P+U+qEtdYZFq87uy4V64TzdQdts29CA==@lists.linux.dev, AJvYcCVoBKnw1BRKJHL1KymY7fiaf4gbODLhthXFDAXMgZsfUiEW1uF9Hieg5i6aFdiM2/dyFfCiJcI6N8km@lists.linux.dev
X-Gm-Message-State: AOJu0YxlhixRMhDK9Ua/UjLY0jyS15WQf0TTmzWf/ZRW2Njocvniv2sY
	6XLMHfC1cXPsRTY6Wzntv3mfi4phTOM0RGBqLsPJEhdfoGsr20iXxj0w/DFTw+R4Nl7zaWah/O5
	2tGpjN4ysM76XeoEOEwuUMgjsSnc=
X-Google-Smtp-Source: AGHT+IGEzue8njdYb9/Yv8+o/LRCA7ZeL1txxLTqIScGAKsOgcAHv7WQdcL1whZ1tdFMEOM+G9dI9M7nb7sfjDyFV5U=
X-Received: by 2002:a17:907:981:b0:a9e:b0a3:db75 with SMTP id
 a640c23a62f3a-aa4834544c8mr111103166b.35.1731653107976; Thu, 14 Nov 2024
 22:45:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241108091545.4182229-1-chenhuacai@loongson.cn>
 <20241108091545.4182229-2-chenhuacai@loongson.cn> <20241114102136.X-knc36J@linutronix.de>
 <CAAhV-H6vTBwi+t8cPKSo44KZKYj8ubwv2vV4FHrNH+nG=_ZXnw@mail.gmail.com> <20241114132740.NuomQBEN@linutronix.de>
In-Reply-To: <20241114132740.NuomQBEN@linutronix.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 15 Nov 2024 14:44:56 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7wzTsSE4hUpfW4MaXAUA5xfXhdERke9zW3E+5apnRxfA@mail.gmail.com>
Message-ID: <CAAhV-H7wzTsSE4hUpfW4MaXAUA5xfXhdERke9zW3E+5apnRxfA@mail.gmail.com>
Subject: Re: [PATCH 1/3] LoongArch: Reduce min_delta for the arch clockevent device
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-rt-devel@lists.linux.dev, Guo Ren <guoren@kernel.org>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 9:27=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-11-14 19:46:39 [+0800], Huacai Chen wrote:
> > Hi, Sebastian,
> Hi,
>
> > On Thu, Nov 14, 2024 at 6:21=E2=80=AFPM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > >
> > > On 2024-11-08 17:15:43 [+0800], Huacai Chen wrote:
> > > > Now the min_delta is 0x600 (1536) for LoongArch's constant clockeve=
nt
> > > > device. For a 100MHz hardware timer this means ~15us. This is a lit=
tle
> > > > big, especially for PREEMPT_RT enabled kernels. So reduce it to 100=
0
> > > > (we don't want too small values to affect performance).
> > >
> > > So this reduces it to 10us. Is anything lower than that bad performan=
ce
> > > wise?
> > Maybe I misunderstood the meaning of min_delta, but if I'm correct,
> > small min_delta may cause more timers to be triggered, because timers
> > are aligned by the granularity (min_delta). So I think min_delta
> > affects performance.
>
> They are not aligned. Well they get aligned due to the consequences.
Then I still think it affects performance (and power
consumption).Because it is different to fire a timer every 1us and
fire 10 timers together at the end of 10us.

Huacai

>
> In one-shot mode you program the device for the next timer to expire. It
> computes the delta between expire-time and now. This delta is then
> clamped between min & max delta. See clockevents_program_event().
>
> This means if your timer is supposed to expire in 5us (from now) but
> your min delta is set to 15us then the timer device will be programmed
> to 15us from now. This is 10us after the expire time of your first
> timer. Once the timer devices fires, it will expire all hrtimers which
> expired at this point. This includes that timer, that should have fired
> 10us ago, plus everything else following in the 10us window.
>
> > Huacai
>
> Sebastian
