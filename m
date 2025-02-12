Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4024F25C714
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739383208; cv=none; b=YZU9z2PbPvGWzcTzwqiRSSXkMxFKWFOEvsC6peT6cDo5dXDZLuAcKkjQeUy+Qx3+TwqnKhZFojNvQ91ow8tmVNbS9lef9RuPcs6Huukim5OxtLduuYAtoK4K5abWEXDJJ+F/3uX7OREs0iYWZgjvs4j4xreOR053BYP/se3SSas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739383208; c=relaxed/simple;
	bh=doZujOukE1DyZJnHcvr4klvWOJqMYmRJg/pI75v7sOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vB4B2nJ1jkhe+60dE/9/zbPPPjwVY1q7LX2u4ViBAtPFXxLgFFWYU6p28D1D8mlBxrimGErvl+CrwIfVLquCtt9kbiabex3giuCspFMnUJrYDPm8RcVP55Dwm0uaxn4Rk8Zlt8jkkD+wGkLn/PqQ8jktg9cAtWo0fDT7ruoRDNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uF772l9Z; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uF772l9Z"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f8c280472so180075ad.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 10:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739383206; x=1739988006; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Fp16qTOknzk8Ci8vytjHzq+U+zw1AGZXtmb1bjqgP0=;
        b=uF772l9Z/Ht5Vq8ZUTVgbs1+3nF0aF7rEtF5Opk+1W2LmQHQflBi3jPrHpNdxgsjKn
         vzKryhkLoz86j0pAPnS9NJs8DKMZ+Q2LPsa2cHWz2WvgrrLGl5l3nhNLqVRQ3L25r7Nj
         lP37HMeE9pnI9CqiDGSCWAuq8MzA+VPJjPfVrFd+natMYYEuQNQWi/EqhvvtduKsKkyY
         coDeXOAjcStUikE63Xpc9yQ+OO4nVSPTuKUOn+qOigxr0pOiwnrIPs0/m3QvZjF/PVCg
         9vDtxglprkyf1X35xcvJPla9oWrBDdccM00YcK+xwiBQVxsjdzUcz26EhpeWxDOTo8Cw
         HNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739383206; x=1739988006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Fp16qTOknzk8Ci8vytjHzq+U+zw1AGZXtmb1bjqgP0=;
        b=dq/lKj3tlbS8MSN5f1gl+9Uqrj8A5BqAxaz6hC79mG2aFHu0xxGIa4uEw1i8rKRnDN
         ILS8/M+0l2K+55eATGlOgxUPJPQ/NGjLN4RwHdwv8rU2gPWJAE7hHaamMH9fu5z27BEG
         bAOrcl5EQULvEvn5ofJXy5bUNznNX8PR5bpbWEvWzGD0trd4QJkQqDLWyqEVXi7+kZu2
         x72LiDKghMhieKIF37114F+2Pgw5bgRun+cSdxFI9cMn4Pp16fB8B+JwjBAK+xwKAU4p
         QcgKobG/oQH92b6ch29C3u/1Pl6ynRUg2E7OaaetxnEorzZ3FVCcVsxExie8Y5AZSnOp
         s+ww==
X-Forwarded-Encrypted: i=1; AJvYcCVOrNjKltrwOmqYYOmMW/WDl2nAnK3pjCoTBYddO8pJPaSa0ZLDcoPDI4HNqJd9UFYGKmzKXSK0juZnGMqS1w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6Yu7Htcs88Y7qPKXJgABRbQxZid/8nL2/bkwENBtJ0TicCfzO
	XAw+oZ2331svor4pmF39rnphcqxLGQmr4vDx6P65xfNlHszRfQJOP/Gpl7GxXNulUrNDKee9CjS
	mGnPaBDvXgrIQLgUmb7ucq5orXM5sf70ZIphi
X-Gm-Gg: ASbGncvfNxzlTXe1r26fejiUzpAd5ezPuxJ1UEYZsYcQ9SGVmwcDo2YZXyI6sSRTam6
	PRkKrypbR0HmTddnuL34L0NxMOC0QbHRNE/C+PKlh3NZvl6sMGiABH0M6+7+qKrBIH6R/9yDd79
	Uhp/fLUNru1LAHvkjtPdauya8xNM+LzeM=
X-Google-Smtp-Source: AGHT+IGSHIXEG8Oo7g2j+uhztymqZqCIa8ogNEhnrV68BmF7ckJcHll6C4PFjbf4a8Afz/FVZ9TfqEgoEqm0t7WgYCQ=
X-Received: by 2002:a17:902:7006:b0:216:405e:8e2 with SMTP id
 d9443c01a7336-220bf324555mr2643535ad.27.1739383204660; Wed, 12 Feb 2025
 10:00:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250211090511.xeFJVnH_@linutronix.de> <CABXOdTeLUi8mKkV38SegM_n8=Uyykd-X+n7RysjpgAZfxxb5BQ@mail.gmail.com>
 <CAK18DXYjsLNS+Hm2qW3COF4_gChPNLwtP1yViY32b+xPkmOapA@mail.gmail.com>
In-Reply-To: <CAK18DXYjsLNS+Hm2qW3COF4_gChPNLwtP1yViY32b+xPkmOapA@mail.gmail.com>
From: Guenter Roeck <groeck@google.com>
Date: Wed, 12 Feb 2025 09:59:53 -0800
X-Gm-Features: AWEUYZn3F_He5ptlBAkWl0fezYHXbo3-XSKubRaoBfPOTAdyS80r2n433ulDYYM
Message-ID: <CABXOdTe3Tp6SfuhoO1ZChsArszkK9d=iBsLZ+gmM7iLT+RYb6g@mail.gmail.com>
Subject: Re: PREEMPT_RT testing on kernelci
To: Donald Zickus <dzickus@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kernelci@lists.linux.dev, 
	linux-rt-devel@lists.linux.dev, stable-rt@vger.kernel.org, 
	Daniel Wagner <wagi@monom.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 9:18=E2=80=AFAM Donald Zickus <dzickus@redhat.com> =
wrote:
>
> On Tue, Feb 11, 2025 at 10:43=E2=80=AFAM Guenter Roeck <groeck@google.com=
> wrote:
> >
> > On Tue, Feb 11, 2025 at 1:05=E2=80=AFAM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > >
> > > Hi,
> > >
> > > I remember Daniel Wagner has been asking to include PREEMPT_RT within
> > > kernelci. I don't really know what the status here is. Thank you for =
the
> > > work.
> > >
> > > Since PREEMPT_RT is now available upstream, would it work to compile =
and
> > > enable some of its tests for the supported architectures on Linus' tr=
ee
> > > and maybe the -next tree? I don't think that happens at the moment, I
> > > saw only a few stable-rt trees.
> > >
> > > If so, should I just open an issue at
> > >         https://github.com/kernelci/kernelci-core/issues/new
> > >
> > > Is there be anything in particular you need help with?
> > >
> >
> > Unrelated to KernelCI - how stable is PREEMPT_RT in practice ? Reason
> > for asking is that I enabled it for x86_64 together with lock
> > debugging and got an almost immediate "sleeping function called"
> > backtrace.
>
> Red Hat has been selling a kernel-rt product for almost a decade now.
> It should be fairly stable.  We also enable lock debugging on our
> debug version of kernel-rt and I don't recall anyone seeing anything
> (though those debug kernels are slow).  We may not have the same
> config options set and haven't seen it yet.  Stacktrace?
>

Two so far.

https://lore.kernel.org/linux-rt-devel/760e34f9-6034-40e0-82a5-ee9becd24438=
@roeck-us.net/
https://lore.kernel.org/linux-rt-devel/d9480845-7e81-46a2-8bbd-bd0ebdbc6a5f=
@roeck-us.net/

Guenter
