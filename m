Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C5120E023
	for <linux-rt-devel@lists.linux.dev>; Wed, 24 Jun 2026 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782317512; cv=pass; b=l5+etMyh729MagB2WescLA0TYH9xt5n7uin/8UJwllHrVElaobONiUjBTjefYzWlY06sDI2vPMwfEuBn1ZBHmBBTJ5eaE/TDg2/ee5/mURDjRLT95J7qMGVTeH88PLPQbduG7n+Pm618k+i7rRFDnCSAA6AGq+j6/U4fsGrCZKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782317512; c=relaxed/simple;
	bh=i4e86Jwp+OIhxo/bQ7S5pnJZz/h6kWIWtcT0Ec4iL3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvaE5+iJnnx1doYcAcDkIWUmlKPethrZ0gbefdjNuL+zEr1DojZcxftjktvJCgUWQTnjdr93kWuHiV834J/0wF/luThdmoawJTuoI5vKo2etlUpuSnA7voOEAqkP9FY6Bl95tgjaSlLHs7PFl3FyUiK5ziDz7INBdiV6xDRuddE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vs6HSUPc; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vs6HSUPc"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51765331535so295741cf.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 24 Jun 2026 09:11:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782317510; cv=none;
        d=google.com; s=arc-20260327;
        b=ShxZmlAIECDZphQErKWYpdwCRxS2WB6ahxM/GKghTD+lZbPxE225VXSo3TIaVj3J1i
         t7rTXGnAktnY0y2rB21ch4MYEv16hRSK9uiIw7WpVmBGL1TPV1ZH6E2ns2J8C4l5AyOd
         ICQEq7Kti9Rww9vHJpe7nUkSrwBxgMZXmrUX3L7GQ9M2L34ddlv+tMs7SVJD97gmdoL0
         I8UmfWb8muDY48Jdro78dbiqNO+LnnrnC8dd+To9gVn1mSDTYYhwsxbhfUiT/hBFzeLT
         hx74mpL9hTO0Dba7qXiPCrOepDYCxYNTLWtYvdRT7DFttp9DUpvaRxLlYWCyxGevYAu7
         SRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=03HlajHYUVXQega1jc/AIpR2MEQ1MKGT9erwN37eJR4=;
        fh=GAkXqJSmtoyJJSoyVfZIga6MMY/MB9oHzu8qq3Zjfj4=;
        b=rPxo+K79JO+Ubacs+NRu06WKO1LgpiHbKqqxJoy4Bm39ssbJHocvxMwHoLXKu518Wm
         Fwdpaxm9nkVbw/kNXYZTslkDmiuDjo0LBEfMiMehC8Op2WpPRta/CyARGj/HidmiySwR
         YxXdwcrwAU5Ioi6s3ylAJWY/yJnlPzzhAi9qBJhVWqwZ6yi+XtAIVdJpmYC4qs43OzgJ
         YDPERcB/KJPYtYcOKMbkqqBHgny4wsI4mlMfBjJ2cpIve6eyepBZ17cHtV8C0g7G4kAZ
         qNUM0Hjyaa0swRjJ8MWDfIS6ULmoaxwqyNBTIosHWNgMo9tQXvO2F6Pq289tCU+C0hfb
         dGmQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782317510; x=1782922310; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=03HlajHYUVXQega1jc/AIpR2MEQ1MKGT9erwN37eJR4=;
        b=vs6HSUPcoHPolvag1c+dYrHoayTMdTQfIoDd8aGZUvod0ozPftjxq7Ac+n0YRCAylE
         jz0QWjLIqGmpLuS5MExGmZulGu1fkgFAWMrxERdK9eUOtoQ/G4BDnTGYRw4aS+pbu7zF
         V7SlcnLPN5olHfe0Hm1P6KNW+KCccnfduu8Sp+GytXapYcwnIT2wAaVXhZ0dFUk5/zgo
         OBaUPpC3TRdEGOtBGr5RTgFPUozbWa010HjLRmqhVv+2UCv/znprt0l2NFBMGyCbVj9w
         nJj9aYBYZZM0+nZdc1KE70C2mvAqwr8ENmk3oLKf6Ypt/7avQYmJBLD2Fd32CM0Ep5bO
         qRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782317510; x=1782922310;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=03HlajHYUVXQega1jc/AIpR2MEQ1MKGT9erwN37eJR4=;
        b=iS5COz4Hyl4hxqvR4OXI2OntLtlB+9GOXsxoBHhBkUw3ERtzqeSLrnU0JzgZ1kRhZJ
         B/3l88xmt+zvJOSZ6uR77xKoqFsZ2Zb/kla+NqDGkUKS79NbTShdfpI14p9As/uyaWWr
         HtpIq8NhQdycTUNf69tZpTpnmWjVLC+CdCxMy3YB1rjOrh9w2mR15ISTyHzKqi6Hl4od
         xyEtPcIBm5Pxhr2KbxeUxUAlw7bb7XfPxkLo3NCgTckChRattWSi9stMqxMJPH3nfU5Y
         cyPG01e5NFoa4WoS5VfKqYcOIPLyYj8By3+jl5ZEx+Exb/Jb1Fb4JckS5SH+Vj5mGSLF
         89bg==
X-Forwarded-Encrypted: i=1; AFNElJ/zQZ+cJ2BxKk9ZCqbzclytJVnpFuzXlggJhH/Irpd/xUVZ5PGxTsrb7VqxXspTfEt1YnuKBrSKXzPhYkWCag==@lists.linux.dev
X-Gm-Message-State: AOJu0YysTbEWcWTX8Wn+y2B8klKljwM5xxEtSyOpgZU926jxc667Dn0H
	KdDvuaiajYLrV2IniN+FIasxSBJnNgUz7YZrG2ZM01TAdTVxAdFnZxEW7MIPB0mTQHxHNJ3BAFR
	zMg1MmJ4yiC7uhN7AswcB36Hb9LReBckGoHtq9azp
X-Gm-Gg: AfdE7cnalDVtXj8Lgl6UTMxQqK7IrWi3vSEbnDCLLegHEYh9SLdt0ijr42zhuXDnXAO
	RE4iZdhtVhX7TsyZ3qDP90jff6LmOc7QJTU2Kbr8OkyADt9VekDB091d6X2gvAz3wrJyalwML5C
	OD4urgD9NUjP8ZsGCwFpQX5OvSePJ7EQsaGhyBcgQYr49XAmVszG0XvE8gFg5PDsWIse9Upi1Rr
	NG7rEp25yi/sWTk8zktMUlfo2F80B2GocmO90l7DEDIp3HsC+K93mAxr1ADq3eBUvkAqwJ6Yrbc
	gAKscR+D3qitRsJHZK+dny/P7D8=
X-Received: by 2002:ac8:5d46:0:b0:516:4f62:85ee with SMTP id
 d75a77b69052e-51a628a18f2mr177831cf.19.1782317508374; Wed, 24 Jun 2026
 09:11:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-5-31f31367d420@google.com> <20260622101024.B89C21F000E9@smtp.kernel.org>
 <DJFI39RWHV1O.MMMMMZSK8E8C@linux.dev>
In-Reply-To: <DJFI39RWHV1O.MMMMMZSK8E8C@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 24 Jun 2026 09:11:37 -0700
X-Gm-Features: AVVi8Cc2zHvrDuEdKpPHHKmUg2PGDzxosR3pi7Y0Yans9uRd-KXWtfdx2gyhT20
Message-ID: <CAJuCfpG9SS+-3St3jBqku3mJrZ4+OQpiuKkZSAaL7r3r4AbtmA@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] perf/x86/intel: Use higher-level allocator
To: Brendan Jackman <brendan.jackman@linux.dev>
Cc: sashiko-reviews@lists.linux.dev, Brendan Jackman <jackmanb@google.com>, 
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 3:20=E2=80=AFAM Brendan Jackman
<brendan.jackman@linux.dev> wrote:
>
> On Mon Jun 22, 2026 at 10:10 AM UTC, sashiko-bot wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Medium] The commit message factually misrepresents the API differenc=
es between `__alloc_pages_node()` and `alloc_pages_node()`.
> > --
> >
> > commit a5667683e56825d97c5814c0349e4de3300e3e14
> > Author: Brendan Jackman <jackmanb@google.com>
> >
> > perf/x86/intel: Use higher-level allocator
> >
> > This commit switches the memory allocation in dsalloc_pages() from
> > __alloc_pages_node() to the higher-level alloc_pages_node() function.
> > It also updates a comment to reflect the API change.
> >
> >> The difference between __alloc_pages_node() and alloc_pages_node() is
> >> that the former allows you to pass NUMA_NO_NODE.
>             ^^^^^^
>     Sashiko is correct, that should say "latter".
> >
> > [Severity: Medium]
>
> Seems like an inflated severity rating, this is basically a typo in the
> commit mesage, and anyone that noticed it would probably have realised
> what happened.

With the fix of that "extremely medium severity issue",

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> > Is this description of the API differences accurate?
> >
> > Looking at include/linux/gfp.h, it appears the capabilities are actuall=
y
> > reversed. alloc_pages_node() is the function that explicitly supports
> > and safely handles NUMA_NO_NODE:
> >
> > include/linux/gfp.h:alloc_pages_node_noprof() {
> >     if (nid =3D=3D NUMA_NO_NODE)
> >         nid =3D numa_mem_id();
> >     ...
> > }
> >
> > Meanwhile, __alloc_pages_node() expects a valid node ID and contains a
> > VM_BUG_ON(nid < 0 || nid >=3D MAX_NUMNODES) check, which will crash if
> > passed NUMA_NO_NODE.
> >
> > Could the commit message be updated to clarify that alloc_pages_node()
> > is the API that safely handles NUMA_NO_NODE?
>
