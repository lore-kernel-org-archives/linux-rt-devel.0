Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BE364AA4
	for <linux-rt-devel@lists.linux.dev>; Sun,  5 Jul 2026 01:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783215359; cv=none; b=loYc3+QGOpED4wk11wTKt9/4xnPiwfQIgA1sMhoIj8xl/JwqvwvJ/UbpDhz4cqzDc4qSwQSIvchm+unuh+1HUIPDF9vFLEt0GcnnSRy/cYltCqN9z+N0BPrvry3W95Rm2LyJNYcoprILik6L4wzXhawjVjHc9bfTp36+vciUlsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783215359; c=relaxed/simple;
	bh=e0snHgkdcCYheSahAts4IyFWJ6tNe4EUZUYM+GSzidE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulCze3bg1kLghbc4WxVlqKwZ7KiwwyuuITVhsC21f7E1OXG2x87CJSm4U/CrTj3Ltzus/317HKBs5gh1egOgENUei5KdmeTJwMFZI1FByEFBC+hWB8VCxzjd+2+fqD9WyzN128+lJx6EkpGhJhNlK6Nf5ZDlZCWlTBdOGOgYlPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=XWF1t4kd; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="XWF1t4kd"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-381891a9525so1503608a91.3
        for <linux-rt-devel@lists.linux.dev>; Sat, 04 Jul 2026 18:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1783215357; x=1783820157; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m42f7L7RVsYe8mboRnNyax0nOV02M22o6ganNTJC8uk=;
        b=XWF1t4kdn2eFNiLmgTUs6zEp5LRXf6VWE+ElD4bEqa6nVSy8uebPCGL7qea0eWVl7w
         eljKTRZBm0KKjmYK08MtdASuXZmQG/Quo+hwxirqZhGc1xBjbZ5WinPiveGTb+rqTBey
         xsFdWE5nhm70h9Rgjx0R+T5OfCqGyNJijbegfozHassDwYet0bphQ7l0KXX9IOXh1GbH
         qhnyRHw2bXLF9FmK88H2q9JjROmsaRo2XiV63ZCFDnYcsRnPyaYdJKPbS4cVGp3qjsRk
         bcKOBcK3Kpukml83MzfZCPgOY09+juLVVOtGWWyPniP5VqEmeCSpxdKju6ZJW8NLTniG
         szRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783215357; x=1783820157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m42f7L7RVsYe8mboRnNyax0nOV02M22o6ganNTJC8uk=;
        b=NLBATnHea86TgW4VPreSNPaQP1KjyUPAd6z6qfaOIxfrRtYJvrr+794zgk1ruLNiyG
         wE5kHnW9cnU0VQn7VU97XpzwLS5mEGrQ7gfv567gD66BjYoXH2AULL1CIatCr6abjfba
         rw+y+l0dm6izXqo3uLO/XC4c7pl3/ZCGYG8Jn+fNbsCh+eboDLHMVNOgDJwdnQPuMgMk
         i3mmt4fJCqCFSxbmn2U2TZAV/GQ5uYWW4mHFEL7jJla+GLgmIgsZ8H+/Nh++dbjbeM57
         nJ0xC6YNMLPjtUa3B4SM/mUVsLEIk6jKpS+NZyPdnjakDkHMrKGzXkYwxZP3s3oahGWc
         AzLQ==
X-Forwarded-Encrypted: i=1; AHgh+RrV1QBgcSWqckRE+0GU1U3U8QzSFHCunGIgmaHDa1O7TLtqQZqEnq5kKGpQDJFEIjRIXxj4Iw8Szy240mzxEg==@lists.linux.dev
X-Gm-Message-State: AOJu0YycjofQiLiPr4rahiqJlo8MmziMsiAixgqEqJJYASbxKZzEXRhy
	yN4QOvsFeBVbL9CwMtk5ZMU1jm5ix0pKKL0IlVEmWLchjIqqhDWDAfRD6ZmR6zVGtnU=
X-Gm-Gg: AfdE7cnMfTkPLUZqZ2azpZTSosPiogLiZSx29bEIBTNjQXlVyg5aN9USa29YWBZXWsS
	f+cBjfhflJ07YKHRcif/KJDJVcMMf2LfIkOmqdOHOi9inqOgdUHV2Vo9niic1t/qajdmJmczNm5
	HdPaDlGAvL67lnSarJkxl94bMjBmaOEmRg15Y15NEscO9qChgTpF5Jn8/5HTQO35sfiIDl/FX5p
	jAFcSBnbypspVNaE019wX8tfVAmOqX4lJmiTv8KVV2Iw0ibGJic38kUR1ZIrUHU1JRZ8+I3xpA+
	QYap9e2eSFrxWFmHNdL+obS0Y+m2bIFi9PbpDeiJvtdHQeasbHfgoIkYoRwjrvWs2vRsURfxIQw
	r9cGR2dMVoqj4PK6zvc/IUgMUkMLuk9HiNaC1dVaOZ0/u8+H8KAB9mv1tEGBPtAYNwmcDi4TSZX
	z5WTznSt2fcWJ8jA==
X-Received: by 2002:a17:90b:3942:b0:380:a5a9:7586 with SMTP id 98e67ed59e1d1-382803b8d77mr5260443a91.6.1783215357131;
        Sat, 04 Jul 2026 18:35:57 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:41a2:54ad:6cef:aed])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f3a9341e0sm27722085eec.12.2026.07.04.18.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 18:35:56 -0700 (PDT)
Date: Sat, 4 Jul 2026 18:35:53 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Rodolfo Giometti <giometti@enneenne.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eliav Farber <farbere@amazon.com>,
	Michael Byczkowski <by@by-online.de>,
	Ingo Molnar <mingo@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH v7 1/1] pps: pps-gpio: split IRQ handler into hardirq
 timestamper + threaded handler
Message-ID: <akm0-V6VTVp7-yQi@mozart.vkv.me>
References: <cover.1780359378.git.calvin@wbinvd.org>
 <2e32729029fbf6977ecf04665eb00f2efd3e2c17.1780359378.git.calvin@wbinvd.org>
 <20260704180611.8898a9e290016d2dda70f6ae@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260704180611.8898a9e290016d2dda70f6ae@linux-foundation.org>

On Saturday 07/04 at 18:06 -0700, Andrew Morton wrote:
> Thanks, I'll add this to mm.git's mm-nonmm-unstable branch.  This means
> it will get linux-next exposure immediately.
> 
> All being well, I'll later move this into the non-rebasing
> mm-nonmm-stable branch with the intent to upstream it in the next merge
> window.
> 
> Sashiko AI review might have found some issues, one of them
> pre-existing.  Please check it out:
> 
> 	https://sashiko.dev/#/patchset/2e32729029fbf6977ecf04665eb00f2efd3e2c17.1780359378.git.calvin@wbinvd.org

Hi Andrew,

I've sent three patches which address all the sashiko issues:

    https://lore.kernel.org/lkml/c5c97c3b3c9d66010382094fd538e59a38f4aacf.1781289959.git.calvin@wbinvd.org/
    https://lore.kernel.org/lkml/672778c177ac9b6fdcb445e35c97ac4ca7d1149f.1780506611.git.calvin@wbinvd.org/
    https://lore.kernel.org/lkml/7a71b8e74bce9582d3286d31e6c85ac77465e421.1780108620.git.calvin@wbinvd.org/

I can resend those as a series if it saves any time, let me know (the
last one has a trivial conflict with the patch you just merged).

Thanks,
Calvin
