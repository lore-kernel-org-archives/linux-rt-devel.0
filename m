Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ABC3E2768
	for <linux-rt-devel@lists.linux.dev>; Sun, 11 Oct 2026 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791747735; cv=none; b=WOMfZEXSfRyL2Tp7T8cNWpVqlEluc+OnI6OXuSUki6+Nxq8lxj/gn4uVgXi10CRz8WGFmwdS/KRp848wvdMheQRCCHGYII0ikThqAiMZGFksX5nVpSOo9tf9dbkDOkCqiSysKgnzLyGAT9Mz/F2b6mVQH+f4QdWRQ7dBRnDvdfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791747735; c=relaxed/simple;
	bh=4AMJ4/YUrPp8c+UnnNwqZYiFxBTm23GrzrPTxaOoYuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjfApUC8HENvHcieANMjAOtBUoCUYmqG/HeCwwoyRRsf9toJr7w9r275QHFJY6Up090PT6JrqxQHFNOgNMrVhVhtkjSngpa9VBzIQD/63tO4v/NATaXnrwXEGN9HOzq0bauZVEHo6TJ7Or3eSWVweL5vNb+BRZNNrczHVfWve30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SR8mfWK4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SR8mfWK4"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so12607315e9.2
        for <linux-rt-devel@lists.linux.dev>; Sun, 11 Oct 2026 12:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791747732; x=1792352532; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z1QFtV7KI5OFWzwbAboD0j9bhs+VlQKq149o9ZSjG8g=;
        b=SR8mfWK4/HXsAFDwsx4NGxtNmvAN4qTcnh9CEE5KIHs+pOrqw36HnHXYvUW2cTNyzL
         wU40coBnzfZfbgBMrDgLXsZLl8IcD89Rg75ss2EtIr2/mSRJQ2sUTW1RTP3pOLV6aQH2
         BPX+U6Y2X5tKVapFLPvIUupm7xR3JDgFMcn9QFiIfcaWGO4Sp52kjTKs+YFf1VJV0A1A
         BCYS2MHTTtTG94SHiIlDNf6FIwUXqCDbfHPU5RONT+LSr+iCqB3L45kIOSCLbUPqjRO6
         aU0sati4K45oJ4zgk1qPjA5sjoRaYTMnCM5AjAql2aMsu3FuCD7V5Ctr/XGgKxdjQEXG
         MOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791747732; x=1792352532;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z1QFtV7KI5OFWzwbAboD0j9bhs+VlQKq149o9ZSjG8g=;
        b=IQgrpfuuDzoak8yHe6mtgf7N1ciCx/h7LUY+wyQBK1LvF4y200L4OSlTwiSLmKcqjZ
         mjNJXAYXL6weJtaVzjLeN1MQsYiB/nUby7AsXYEDM9pteyPkidk+Ol0qqs/zeaWin9CJ
         r5vVi8k7tdjQIW8gyJyrYGRGiIF1KMXWHcKCh7LU2Y02QiJG1uUB6xeqQuzbugz4HvHO
         eWVkK8uZnWAukOVnM2aHGE+iG1wb1VG2xS0aTViCTuvqn6yKfCM7Ykbsj4Zb3iyF+Rex
         XzxZjtk6nFkqA87gR0psn5X2iXqyI1mAJc9ENiblypjyejT7R/7DxcNJqM4bHVNLWqWn
         XD0w==
X-Forwarded-Encrypted: i=1; AKwUvBwK82JLE32/IuO59fZoITEzfyYhGJkFNsiwVeJ82SLaEXe6e35cPxoJyyH8WROxruj7JKKyn1mqXAkIWrnqbg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJICyZDZH0UFoVrCA9q4iUC0TpH/R6FNMC96AUX/q/Yc7TTjOev
	JenSCuKvY2DOZJxa6jT0w3WeULiGsKpkMLO5CES7sA8sIgMwuYBzQkSr
X-Gm-Gg: AYBFou0SLJJbgclU/O8y/PCruDtuPmL7LkaCpq47axHdH7CC6zIH0hE7KX9VFDpuS3R
	tdPYSyRqDiSEM0sR6ROl5CubB5sIjir7LdD+o9IKsH2v9EDDLNjh4QJPOcLvYCKDgQBVeYhDpLE
	jR/rAhlcOfnHMFA1ZpCBbJGy+tHWZ/6u5yXi+LVK8pMny+MSV1l5XZgrFD2H+fcB+7OhLlAp92e
	+2njVCgQk2Vfy6GG8+uxw07XBJvaId4Yd7glQ2T3c7kU11xsFnM9Cg6r9t1eHrwJAaNsEjU1R8Y
	8lUvGdNqfohSU4Hl7psh/5JYPKJnuEbqcehE3eOjRA5K0Uikm/oA+GduPxcOcqf5oFZsoRZQEAi
	/4R33lOMkknYyPPweJHiVjmqgzsaulSpsVVTC9iED1txwYt96AeJbRbie1DJve9doY9oZTeEUse
	4X4UiwqJ6/ce6j8k4EAyIZWYO3Rffu+rdh8+4yOBN/9mjq0f0ZuzVijT20dZgkDiAlg9m4UHJ22
	7vA8NyR2Fk0lc9A12cJE1yam7SQY1YyXU1+4kaW/MlA21lhuhcGfD+2uE3LJ5ISbh+ao/KrNb9o
	XgazXQkXsoFiy/vixA8LLJZnlwEfPBiAKLfRIgjs+xN1FaU0XMNE4I6hNkexIjfvO8lRsLBAcrm
	cXJ4b
X-Received: by 2002:a05:600c:34cf:b0:4a0:159b:d2a9 with SMTP id 5b1f17b1804b1-4a18e4d68aamr114369585e9.24.1791747732221;
        Sun, 11 Oct 2026 12:42:12 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a124-4001-d491-d32f-6b9f-21c5.310.pool.telefonica.de. [2a02:3100:a124:4001:d491:d32f:6b9f:21c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a197c465b4sm89015105e9.3.2026.10.11.12.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 12:42:11 -0700 (PDT)
Date: Sun, 11 Oct 2026 21:42:10 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-wireless@vger.kernel.org, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] wifi: brcmfmac: avoid sleeping tx locks in netpoll
 contextg
Message-ID: <asvjWF8q1injcEIh@gmail.com>
References: <20260930185417.61865-1-kmehltretter@gmail.com>
 <20261001075755.3MilPS2C@linutronix.de>
 <ar7vLt5kQ2HJoJY9@gmail.com>
 <20261009160015.9YCN8Lt-@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009160015.9YCN8Lt-@linutronix.de>

On Fri, Oct 09, 2026 at 06:00:15PM +0100, Sebastian Andrzej Siewior wrote:
> > 
> > Source inspection also identified 8139too and macb as candidates: their
> > transmit paths take ordinary spinlock_t locks. I have not reproduced the
> > warning with either driver.
> 
> I just replied to the netconsole thread where I did suggest to lift the
> local_irq_save() part. This would obsolete this.

I've replied in the netpoll thread [1]. The netpoll candidate's RT
locking tests look good so far on Pi 400 with unmodified brcmfmac.

> 
> > The earlier netpoll/NBCON discussion concerns NAPI polling and
> > scheduler-lock deadlocks, rather than this driver-lock warning:
> > 
> > https://lore.kernel.org/linux-rt-devel/20260618111554.2n0pP_O9@linutronix.de/
> 
> There was no fan club behind this change and PeterZ hated it so I
> dropped it.
> But this deadlock should not happen with nbcon or do I mix up things?

No, you're not mixing things up.

> I don't mind if you have something to optimise the driver. But as far as
> the netconsole part goes, I would try to kill it at the upper level so
> the driver is not affected.

Agreed. I'll hold the driver revision while we discuss the generic fix.

The generic fix still doesn't address calls to brcmfmac with
interrupts disabled from non-RT netconsole or atomic writes.

I still need to compare the unmodified kernel and the netpoll candidate
on hardware with firmware flow control enabled (brcmfmac.fcmode=1 or 2).

[1] https://lore.kernel.org/r/asveuLDEf6a44bkD@gmail.com/

Karl
