Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89C347140C
	for <linux-rt-devel@lists.linux.dev>; Fri,  9 Oct 2026 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531042; cv=none; b=ay8Yok3MvySq1FOiPAmZ3/yoU/Qdwl0cQ37nNXarGVlQsnjvjVglPubJbKelwYrtlLyVvc18VYNqVV5nTy5uFqpZJPPm8uAMpZlmpGrxAgHqFFe1MXREbKfAIdxsgtT0O6JSnJ8XQECCbqQm1DxH0FaA4BoeRqWWwsTpk7Y/guE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531042; c=relaxed/simple;
	bh=m2sbDzTVz80zNixXWIi0WDat1SU37qeKuIL9ZzrWE0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8p32DxRoHY2hh6sZNi4lxkWx/4ZopRc94uddYZLVyrK9dJ1m+OcbHvHn6pnGWh+XTfFX4yPuf6JJg0eL9Gt215C07lJOGC6fhExq+UMWmICxSay9J2NHSZuaIDx8nUjmX8AEw86383+uo7OGTO6i7El33PFixlLTg9bIZFg6Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KniNOG1b; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KniNOG1b"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso55302365e9.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 09 Oct 2026 00:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791531039; x=1792135839; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QhfdgCnusoug/g1d4W12Bzr39jd94gg5/ulsL7PdlMY=;
        b=KniNOG1bZhU3dl8ZVtnDHPyGblC+2J3zP1Z762jwv0yFqRh2J+DArvhiHJUz3uku+S
         JIEqF7QRtZNcrxtAmIgfyBXIjmBUfpfY3SJcMYUfK3EPxIT+kmRKfqvKrZ390N++bJj5
         c5im7S98+bNeH80NrfGE3jTTa9ByN/ZVYsBnpFn82O9nGqFG4aseWqACBArv3V8ojdoX
         iEsUi00oMOQi1y31KYs4cVSxUQ3wx2vZTsVoF6BQJapNsI/igJNtHocDtlsBrT8zpSew
         TBFP5AO0dR0pT/u4gMUyzkJ+zyYF32kXCgUVYIwqULkwAkbuIPxT6eqtEt5vy1AVRww5
         iM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791531039; x=1792135839;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QhfdgCnusoug/g1d4W12Bzr39jd94gg5/ulsL7PdlMY=;
        b=b+R8bCCNtD+FKtSGPi624DePISuBimz85VzpGDdUAmmIGWHciaal9mixVPCyas05bi
         7rDZODnn0MFO2W06lO6jYC7Lpi1JZX+6B1vUK8jyDdKbLrHFJ7i+QmR6Pq7LIqYnjfed
         jJtkm92uHSbUTuJJslxVfsf2CoPA8K32Ku8U51NQ3v6Mk1PxxGYlP4FlbM2KdDfI3Td2
         hAEuuZkljqVFr6bN/6dNUGK5Mpx+isFx9GEN8uCGzhZoUtU3LMNMctPzo4GSWEfoNa9G
         zekaLenf7jV4POn9SzQcTtn0nJFrz015XIsARD3Mp8AwsvAdD+dKjUq9cFYmfe5haHlq
         Y47Q==
X-Forwarded-Encrypted: i=1; AKwUvBwUcm8Hx5rFqZ1G7UVID77qVWtVCXfi1hNKR7fpMLf4k1zOJTot3TEdPjlP3B0yv29ILcrL1bMKe5iaX4K2iQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lGAOrhDSwO8DQX2cYVGYkiJ671SVL+2/k4FlNobpE1xNLZjgO3
	z8bWN3EApkSJZO/Ea+Xj6iJhZTLA2AlJV2Xumca8wdN03bN1K2+cwROI
X-Gm-Gg: AYBFou2L6/+ngCe2vK9ZZCXJeBuB2LY9b/eq6n/AbWVrNGIy8UWWg4vflJe3nAmPB78
	3d/LVXoUuxBy2E+RpC/jJsAYmVBxX2rBGI4ghCs2mdzyOtSLfLec2FokvBo/fe1WFLm/b3oYMz1
	ij2NkqQrWr8GfkU8OQqU1N/dM4Oyr1iO5mIMC2WywyNdnknQPRblpqx02cSyASZ615RqMs7xUuX
	Ere2vqr8fexQj1okQSMzabjxx/S+5kqm+wq0Gl7GplKkpXuZxGE89ao2ZbBKEcK2ZE0HIxBFNkw
	xmdarGDVHAT5+4vr4v4i73haDjbtPS9qr9sgAOldQBpLEMM2Hpk0ijills39LdXCcebChC56G60
	5hM824p/Qp3pfGy2VOVwAT3CHIbLASolTyF/1AofNarHosvfx9sWye0Uk5GCbvoFOaF49Ua3x/H
	/DGx+a3bc66CFZFacu/aR3ifRRDeXOCO49v0g5+bqlABkb3Vw4dCfYThdfTkpzG3kuvK8PqXaEf
	2Em3oe0WKwZw/4K4n0IpuXNiSU7Hbrhe2Bp0Fx5ivQTzHQiujZQDGDrxMqeGEOZV4CPJ2DCCICM
	xpM6HvcA22+QQ0cKmFQxx1YtLpMmo27e4DJpcxLVkGUlciN0i1BaFKIvPzVa5SZQGEF65onbOQR
	z
X-Received: by 2002:a05:600d:82c6:b0:4a0:1fe2:d4c8 with SMTP id 5b1f17b1804b1-4a18e4a4c3emr19524635e9.5.1791531038809;
        Fri, 09 Oct 2026 00:30:38 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a128-aa01-297a-7094-853e-a20c.310.pool.telefonica.de. [2a02:3100:a128:aa01:297a:7094:853e:a20c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf31b83sm38426495e9.12.2026.10.09.00.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 00:30:38 -0700 (PDT)
Date: Fri, 9 Oct 2026 09:30:37 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] wifi: brcmfmac: avoid sleeping tx locks in netpoll
 context
Message-ID: <asiX75kRueyFqWuO@gmail.com>
References: <20260930185417.61865-1-kmehltretter@gmail.com>
 <20261004122910.1392318-1-arend.vanspriel@broadcom.com>
 <asR1TaKQJlPFqEvR@gmail.com>
 <802a092a-314a-4f77-aa1d-134b3d020069@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <802a092a-314a-4f77-aa1d-134b3d020069@broadcom.com>

On Tue, Oct 06, 2026 at 10:27:27AM +0100, Arend van Spriel wrote:
> > 
> > Lockdep instrumentation in fcmode=1 and 2 confirmed that cleanup enters
> > without txq_lock.
> 
> This is an observation unrelated to the patch, right? You mentioned in the
> patch it only covers fcmode=0, right?
> 

Yes, the cleanup observation is unrelated to the fcmode=0 fix. I
mentioned it to explain why I kept brcmu_pktq_penq() for normal calls.

I'm looking at a separate brcmfmac FWS-path RT/netpoll fix for modes
1 and 2. The prototype defers IRQ-disabled transmit to the FWS worker.

Are modes 1 and 2 used or recommended on SDIO devices? That would
help me prioritise the follow-up.

Thanks,
Karl
