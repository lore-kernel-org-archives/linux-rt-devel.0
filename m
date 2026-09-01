Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B019F455636
	for <linux-rt-devel@lists.linux.dev>; Tue,  1 Sep 2026 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269522; cv=pass; b=X9u4Otfm6I+vvMcleHlesnxSbkcBj5Udnn7QReuDPTpPr/Y5ukPPAfcFRDoWJRMY4dWQO72m25DTAm6MwykwoRTy6E2vVDeedsJk4KYdjrSUztzf+P+GNODLM/LUP/UkxxvnVPJfcFym8b0C2Cjc5lfDI5tX33YWwEcau05G5mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269522; c=relaxed/simple;
	bh=wZOwL8jjh/wZ+UkZ6qjNSSvlXdI1Qks/Ut2rtHKEXWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXYyQOTChM5UW8/ElAh2voeoVm3YAkAnIzwbzrNGlUJ4cJNC5stn2kZrN33EQfn9KiDaqzUry1KSn1MrDr31sH5fh0yAdrG6+lRoOnhMlhHuOkDQjqL51qtuLBYSROR2frDwFfjpadefJcfXiVnIYMkBCVon5w3EnGq15jMbuCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WPuRVzmm; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPuRVzmm"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-398b3c37877so3884596a91.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 01 Sep 2026 06:32:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788269520; cv=none;
        d=google.com; s=arc-20260327;
        b=slBm6CoDtcpQ6oLjv6NWdxnCiHy1aGj4rK5f834US6izY2asomfDC4nH5u36Agx99k
         52A7XfwBPweDUZch5wQejiUAuVGWWNRbI2sQvKotbv91vUpb74sWyKAy9NLOkxi+BFsO
         VWvVkRGsWdlIKMgN4EW39USqrch8rBRkuH0g9uxGIXYZpNZbMYGSHxdbcTZFFEcnTHO3
         epqKNdGx4jggHcG1bUOfEoCRfIGomHd5ZqeUPnjpEiqFUcZKzKUiSKIFeDNg60Ul2Jxy
         LUIhdpu+l30mhYjhAYwdqHy2U8Sb0uxdF6BGc+l8nlzBwjw9K77bn8eA86jpGgJayyRv
         SojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wZOwL8jjh/wZ+UkZ6qjNSSvlXdI1Qks/Ut2rtHKEXWs=;
        fh=Bq3HWUaH5b/kgkxqLNh6rgfG8867CA34AW4oLOBejA0=;
        b=Ce1bYPJkm5jxFc6II/PU6lZH9dXfKWFiVhNhGx0OS3+inpe9n6cSsiyQBnxTsRPBeL
         jHmjBig+AYVAu3ZN9kJTNYzQWPMFTq3AF03kmiuHwE7H19ND2OWnHG6tCnz+T4SylW2E
         vZpOpIMBD/v3nxayTyP1ohhIezEB2bRg4KUmyXY4I5YogLFLUG4XOD6di91d/6aGHFna
         fWhOoxf284mdjvTMRs3rVUnyo/9OduC7CSghjJTmAhTY98/4DTuYPNdzO7+SRYjBXuZh
         +fOdhC5sMISRU+7uGSmoHnN90Q9TkxW+rNLgJfFNLdNEchc+CH85LBjO3SR08+9kguti
         Cj1w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788269520; x=1788874320; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wZOwL8jjh/wZ+UkZ6qjNSSvlXdI1Qks/Ut2rtHKEXWs=;
        b=WPuRVzmmIErwwgHJBoTk+4nRGojZJrtQGAZyIKPuBypL5tL/TuWYx8aA6rjBImygQn
         1lG01k+HTUcaaPsD84zMkz3nQb0/BwrJSIAXzjFHFrnaGgCp1ttI9g0df7BIX+TlC+iU
         5KrLA79XxXu+HDX6iL6tiZElsHhbg/bgfygls+GjyYBSc5ZBvb1I4zCUv2g+mT3ZaYbi
         fH2gQHZ0uH9vgnXiIbdsMjQAn5++hzxmWSxs53eYgw/hfkPpdgqNlHKqxgsCHKNa7z8e
         zud/vu/q1kGVN0CfXmP8UUjO6Vbs0Q9WII3m01vroD29N47q1mOAuJJJbrIX83AiAMVv
         s0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788269520; x=1788874320;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wZOwL8jjh/wZ+UkZ6qjNSSvlXdI1Qks/Ut2rtHKEXWs=;
        b=MnSEQr8pIJ8vaPiG0zT+/H40Hqu74Yl3wqmz7/vjJovpjJCC8pG5reH1T0B1AG8OAH
         5NcgR4IIuDx9SuAJ7EIDgYKMjVlrpnE07mm9DypjBtdIGgyVTE7on6GJT/nNFRyzqVWj
         Hjlam2kF9k4HOitLbeiYAHy9f1sJ8sddiUpwzh6uJFJ8JBTzgNbrc1q92C6qfiqLXm1Y
         1ep9/VvKAHzWx8qCiA6l9ePqdkeYOTK/Da4vls32a9fTLjt2HLjh4TBZqtyB2+Ken96s
         kcj6ce18mHnVzFDKWgvnVwxeKGdnLQBgOipRr/gTdbuvNxPIlCn68gslZ6T/adOIHSkz
         zObA==
X-Forwarded-Encrypted: i=1; AKwUvBz0TvCx3kqYPy1BzB8XPgO1kqi8UwIdam6YsF3ROuggYEJ0soMFCEx9/kiqf/z4guNg4hJGm+7asKRtKtWOLg==@lists.linux.dev
X-Gm-Message-State: AFuF++lOrsihXIV5QtXHdtF7EWk/zjuZy4LAMfHA/ElR1XT5i08J1ssb
	fbkXKmySe3ANPSMAXN+2gb3nICULr7akZWK509IcLNtjU2UQq/GN6Q8aUJJzirgxV7OBxMysBlF
	C2RNPL0O52ILoZlAMDkxrLiVjIfMMpLwUNzY29nMl
X-Gm-Gg: AYBFou2wzWlrBauYMI1/KTcSOWWpnEUyoCk+qKN5rQtHCvPol7b7u871YjMQyBa6zfz
	oHS1OR0B6DxMMEvjFHQmPJ/FHKdo1JVpabZwZw+NFJ+7T6Qk9QeeO1LZJ27wEQO6/cq6SJl2HrE
	bmWPIOeV/FhxOX0StH+zfy63DNTw9ge81uytxHYdAh5DzUx9NiWLLVHUzChwlgTZelsq9qG1ppj
	BFAJYipIj/zuNDrfeukDPA1NlJyAlcXKP1iKenyfT+Vb/Sr2/STEwOfR3gdglnQQt/W7le4l34P
	gpQYHGPDYMqG8iTxbJbxW44sBXBHEC1R/vi6joNBNSyTRgFkSKimMfN4aGHmxpZVDOsiNsPDFtc
	=
X-Received: by 2002:a17:90a:120f:b0:398:ba0e:96f6 with SMTP id
 98e67ed59e1d1-398ba0e9e53mr20108468a91.23.1788269518890; Tue, 01 Sep 2026
 06:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260811154111.64669-1-kmehltretter@gmail.com> <20260811154111.64669-2-kmehltretter@gmail.com>
In-Reply-To: <20260811154111.64669-2-kmehltretter@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 1 Sep 2026 15:31:22 +0200
X-Gm-Features: AcwNN1V5-ta7UHgBf3Dcag_BjhNOVYaKS4dBVAyOmGmGTx4T_aCNwsoWOCcFjO4
Message-ID: <CAG_fn=WMH86JrNVPvz8hDHdc22asjGtETv=mCvg6E0UHqN8+Dw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] kcov: Use unsigned int for kcov_start() mode parameter
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>, 
	Bradley Morgan <include@grrlz.net>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	linux-rt-devel@lists.linux.dev, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 5:41=E2=80=AFPM Karl Mehltretter <kmehltretter@gmai=
l.com> wrote:
>
> task_struct::kcov_mode usually holds an enum kcov_mode value, but it can
> also carry flag bits such as KCOV_IN_CTXSW, so the field is unsigned int.
>
> kcov_remote_softirq_stop() passes the saved raw value through
> kcov_start()'s enum kcov_mode parameter before kcov_start() stores it
> back into the unsigned int field. The parameter type therefore does not
> match the values it receives.
>
> Type the parameter unsigned int, like the field and the saved copy. No
> functional change.
>
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
