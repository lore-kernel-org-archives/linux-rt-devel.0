Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443773;
	b=VtFHUwqG0BQWxPZXtej+R4LrJkvsYY1oTo3/FsrdJbZdZ5nZ1B7faWjgMDsu/2nU+BoV
	 AZFs9h65Gxu22Mq1sF0bxcaxycXUOTEF51njtfsbydwP9jFG5Kt84xquz25vLTU4C4hRQ
	 2CJKZtt8m/YslIVfPlyRAjlpnzrLhqreKDsCRZ3LMQ593H/jr9DgqM5VdHNVKzZrbvQ1h
	 ocMlT7N3H3bhTDL0bEkudHPMQ5mZShJvq73dZUuYtjOy2rnDj6cmqA/WaG07XY5qwyPD6
	 UuThBuJNYnYaIo1H9LBoobV+luuu9n2bZXXzlE4NHWbMT78zhkLxHd26EQGKKgMnsnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443773;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=xFtfINSonkJB+J7cDg4OJ4WdR4XOLP+Q5XiVEZloT04=;
	b=lbH2brZtMa2cJ8tvN44XRn4M5HxV52OtJ25lHkglDpyRBkBPY5Kep3cPrgiDTBySii+7
	 H4FU79+XeAKKW1Dmz1xpu+bycymmBdptTbZk/Un7ApTZbj+lMXJEn+sM3R1Ah1Dw59jmF
	 OW+aNyX6hdv6/EgI7Ow1uruHZwKN21lK8SBQydvp6UlaCrQhbV7/TmqhrOgQzQ1N355ix
	 0EOzsKeYIfQ6Y8lsOdW3+COJdZ3DR71bHyxQi/AZpNAyJjCeEOGewPJB2PT8p0Omyukdb
	 8wL83SNezrPWDhWeej0qKkijHJFjzpOtpxDafOgcjPYW92NpLzJryNVAUdq0cW6w+9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=ZtszNgHA;
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88DE606A31A
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 21:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C88DE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=ZtszNgHA
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7f432ac553fso1838694a34.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 14:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792443772; x=1793048572; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xFtfINSonkJB+J7cDg4OJ4WdR4XOLP+Q5XiVEZloT04=;
        b=ZtszNgHAYg7CJPUzDcZqIuip5XeB4PpZ43NjXkYGK1GoVOIc48BAC/xXug4LUW4k69
         YiLkppoli+uCcpS6bGhytqvnow7d2FXu1aHm1Ri2NDOwoZ0FDQnmuycRJDsW+ZzQ3yu5
         bnACFy9HVYCO1Zw3Og4iwwEx1FfiHZ1f7vYCy7nTWCwJjBxeghU54IpbNTaURxn+MDvK
         61hMmxfcAdhQekYRpJo3nwmRjeQObpAmgDbRxDYsXTGVBqxu5WceerbFLcuaJK5abc2/
         udEdj3ii6xiNpa3mP/v9FoLVIrzHCqDnR8r6VAY4e06suNjZoibI3nwXHKHGsVjYCMZZ
         RB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792443772; x=1793048572;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xFtfINSonkJB+J7cDg4OJ4WdR4XOLP+Q5XiVEZloT04=;
        b=YqYtUbmKj/DgSUWibVNIHppQyegU5QvVvRTgDtQdl63qoKJjhgSo3r8pUSwipv74hz
         wtvlJZJ3gn/hSla46nv1YptrptRDzxUhvckbTU3yRWJTKC+wkwMTf+oLT3Nfxwe7HEUW
         6I9VLKYaMzZ46y+NBlQTyCZsn1NeUEFMe6JNVWQXK9TSlXMg1oyf47Ri9cc04a1f477O
         BHdPZtNrAANvrDudSsdrnQXtEIAT4hR0tVWEfMy/PIzQc+2sZM3iLrgThnjdUahdKB7e
         6lpx6DpmaFByiFW2pkK9+GgtcAcX8FjON7vAuem7cLbO0UR7DswRC5lgEWEBPN7+zKRc
         Muvw==
X-Forwarded-Encrypted: i=1; AKwUvBy7QbGpGkCXyvJS64HNdLDz1ZWAMMWwhGY6JIE5j9DnKmuO3MczE7WDHJlnBmixM2o3mKJGr452oSDuSu2UPQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKc93S32DeNYHcPXzMwnc1o1AKQim6PGQV6QZtqNZlbaHcQWdrj
	/XWtysZbbfddRF3MkCp5ujpLNj2Mvmchh5jlf+pupk2dfyzZwh0SUpL3oZyj6vEqLZ8=
X-Gm-Gg: AYBFou0NZkhtvkOUPDdbF/XYKmVanW9xmVyTqXehibJOLE38aEusL/WbyeiiuD2U+WV
	KhP7KLLbfSRy96OqYqKlwFiF8dvyPx0QuOFhvygiTobdCs/elcB2/J6mjlX4I3woDyGrBS/YwQ3
	akNl2ik47ntI0bO7ize2dfNgolVyXAuN7oEL7a/h1yy8tg1rDw/Y14Z9p7Q1Wp0irKAW8hvA1gN
	55a9iNS1DTSXyRj7nHe9Y0//YJa6Ks7PjK5NZDWuhoxsW1wZco4csBW1Keigmw3gLY+IRYQChkR
	QbqG3IUQ1T7SGgm4al8P05r084EJm5iTiVTHtO4oYc8MMWUBpqDvXSp2pLuBQsga9THPu8wtQgF
	IFbrttx8rs0VAtX+lLHWXUOf6w4zRHii9RxnJQKHuVJNwpDB+PeZ6mb+TIBV8SW0R8I7pmLSodf
	x7bMexcjY/mBjid5VOE/XbbUeWVCF9UfpuRfbAfDWAU1tjA/NMwdsnFKaATzJn80wzHXJL/Ifrl
	kV8HZa7IfwjewaeqHUqtoA4oDKi5bepaNwqOKMkRrjEXS9FG3g/po8=
X-Received: by 2002:a05:6808:17a5:b0:4fb:c2dd:c7ae with SMTP id 5614622812f47-53cc2aa9259mr8493736b6e.6.1792443771712;
        Mon, 19 Oct 2026 14:02:51 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388a5572b4sm7960424b6e.6.2026.10.19.14.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 14:02:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Austin Schuh <austin.linux@gmail.com>
Cc: bigeasy@linutronix.de, io-uring@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, clrkwllms@kernel.org, rostedt@goodmis.org, 
 tglx@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261017171726.601443-1-austin.linux@gmail.com>
References: <20261017171726.601443-1-austin.linux@gmail.com>
Subject: Re: [PATCH v2] io_uring/wait: wake real-time waiters from hard
 interrupt context
Message-Id: <179244376847.3231032.17554903346880483813.b4-ty@b4>
Date: Mon, 19 Oct 2026 15:02:48 -0600
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sat, 17 Oct 2026 10:17:26 -0700, Austin Schuh wrote:
> Since commit cebf123c634a ("io_uring: implement our own schedule timeout
> handling"), a CQ wait with a timeout sleeps on io_uring's own hrtimer
> instead of an hrtimer sleeper.  On PREEMPT_RT, an hrtimer that isn't
> marked for hard interrupt expiry expires in the per-CPU ktimers thread,
> which runs at SCHED_FIFO 1.  A real-time task waiting in io_uring_enter()
> is therefore not woken at its deadline while any other real-time task is
> runnable on its CPU: the wakeup waits until every one of them has blocked.
> 
> [...]

Applied, thanks!

[1/1] io_uring/wait: wake real-time waiters from hard interrupt context
      commit: 5b01d5955ac206e38097f777eff6ab2a8b948c41

Best regards,
-- 
Jens Axboe



