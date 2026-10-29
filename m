Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284098;
	b=cojuH0DjtUXtBdNKWsjnardbgdGCL0TVpMgVsaUL3RRg2mQ8CIe3qGqQD8STWpOZiLfE
	 2IDrO01w2VmwfGjCYggLoApCdBv12d0DqyQd0DMUY9YcZhCS8SRa8biAZsFCXBMJ+rjYG
	 umg5BpyPBjJ5OPEkGozTCKjPv7BkmTEaHrojt6R+hhqxiQYJsWKJ82Jnwc1hCh8NZh5md
	 uN+IZkvvleEyZ2i0EyrJzKpO3KQ2OMizGt8tfBgxvUR9SU2UnwykfSEtSgQSzC4eeb3jO
	 GR0cKyPpbFRxA4AwEh4HArARtWm39IF10LimrqbydVnOpGX9XBirj/n9Le7t5VMzVgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=bpV5gcaWSkWHUEBL8Okr5cQ7G/7G2sdwutpL6bB3z4g=;
	b=Wkntxg8YC4IIp8OrZjvXepozyTD91umEPGn2kRvpQw7M/aWG+UYnDtMTe54OyCe1F+a5
	 746B4JgBx8cSSg1wXdwP1ZI4soY1ddgH+CINRghK8gBx7DFM0kMTfz7MQ2tFtvdb/Zx1V
	 Teaf4l/rOpsO1LnDQylbrtD95IfQKJdXjBUdaIQvUuSKZs6ekRfP9U7cu0TWtAOtPr8db
	 285BqIU9jjydR7HfhwX/tUBKjUqaXqogCh1LBU3+AFm8wIsgH3QGUhDS6/SCZ7PKJdkCC
	 oYiXiJjeVPc69nFEcGwG2yKiCQ5+QRplj4ioE3xjIgeVSaiLBop6dYZOJOyisd0dSiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=q1cHaC6j;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEA2606A31D
	for <linux-rt-devel@lists.linux.dev>; Thu, 29 Oct 2026 14:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CEA2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=q1cHaC6j
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36a17a332ecso3242724eec.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 29 Oct 2026 07:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793284096; x=1793888896; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bpV5gcaWSkWHUEBL8Okr5cQ7G/7G2sdwutpL6bB3z4g=;
        b=q1cHaC6jufexKjniWRThFnv+e+YCL0EtxHz27YNqQag/81wPuWapOLf9OFRYcegpg1
         uothVASl27i8r0TU5neozTHkD0TXKMzYGswoT7htdaPRtgDLbEMRGfKjJ8Q8iKYvgzyX
         puZNPTjFL8PxhlfIkbNEnV4Rj/4AOhrWnrpUnHZELVAxoeOf2N9TTf39o6EW8RyDG88a
         Xfz+nlb/h1RK7iT09c+nfYlIkX8FX/qC5tsvOFJ/7U7Xmx6RCoUpft2QsIIqtq4C06fj
         MIYsf9yl6nIBSat18cGmvGQORzYqZyueXUdR51wNWWHdgU/O5TsluNLGku9bMAbvbgyd
         itxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793284096; x=1793888896;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bpV5gcaWSkWHUEBL8Okr5cQ7G/7G2sdwutpL6bB3z4g=;
        b=ixj4h4DqdQPWzOpOl7+KOcQwqAm7w4ZDyEJwyVcHb0IsdcrmMO61VAXy8hSVsUV/cV
         nuLDIddrN03804d3EfPSbTQwvn3S67sr8wX2uY9gGFPZUvJfWCw5WfcIkSsDf6rKp1AD
         gKxPPPBxU35YORmgJ5704floYhtoa4Z2KNfrvpoJlCPB0D0QNvnc2QWMD9P9BrDLi6Qs
         q9Pn3Xmg2dniJ4raUUK0U4bwLItOsudu6liy3oyb1e3U4oGJ3AHPFZwW7c5Ea33G35sp
         GsOW+8h6ruN1N0x4b13xc0SNAxBFGSQe3E2rA+g/KEFkH+oGqIH+5K2cX34J6uvAvm9H
         UfnA==
X-Forwarded-Encrypted: i=1; AKwUvBypcMnh9DYRAfRYj2teAKddvLckNmb9pGX4NUbhou/117n8+EBpjH01n8Bh9du08dw2mH+xZD6fAhI+WroQKA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKu5njuIWvwXezyKfJ+r6ducn8zxVQHT2jibrfskC9SZFoopJaZ
	VRxxj0K+Vu1vuV8FvY1hPRnJBXVI7Jrkr9YHvXGsKCuH2RtciOM2CFvjqkjE/T3BSDY=
X-Gm-Gg: AYBFou1PyNo0hgQbsjAGdLvMY1VZMQE6iCqsTA5U8rtXxD6ZJWuNE1uQiSMTnanXIID
	n+6dN5kTUctErSXHjvWakc/F+NxwKj/gBkFTE4dG3ZaKV0PxST910CLBxIGo6aw+c3w+vMONw0d
	w7F4PPZMI6XNLNvWn+QcoECLIs2Ajr8EFOw8mFi8G0Z1AH1CXC4JrPcugLd1ziSxaggI1J35PI3
	izFl6mEW587mQ84uUzIvcNO7/h5gijwAj5BA80/ja6Zp5u3jFlydh3yB+utNhufcGNyIwqQCBW5
	6BMeKz7Cn+/SAbZPEKcnR+yjuyQ75OedEtic6pTF5EnbLHr2Mwr1KkA0RE4eRmykrL0z3eDUsMb
	fZLqxHKxgG6SUUjYNQpaatFc4EbncJxcpVkIlYspW7/Nv9l+DnECGXPPdEeouz90iS+CzUU/GRM
	gmMypb1lqvcK+ybU2E/jAbqRKR/sacVOZFqBLTCXSlzUVx7LmneDaDTWSh+Dn0U2TtcXT+5+LQa
	QhdBpL7NivTOO/mgSagedQOgFaBGNJcp3F2ox6h5GhGWTQEJT2qwepnXtMOmxH2h0FxikMUEQ8b
	71PTXFsCIS/XxCT2OmKGVSPSYqzNo4c3XI0E8ftdWS9/TjUctI2dNL9l6NGCEIX/j0rP/lBNB6E
	KrEJzx8zrGknL
X-Received: by 2002:a05:693c:62d2:b0:368:40c6:3a01 with SMTP id 5a478bee46e88-36a1ffc5574mr8656318eec.2.1793284096076;
        Thu, 29 Oct 2026 07:28:16 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23951e00sm22271573eec.20.2026.10.29.07.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 07:28:14 -0700 (PDT)
Message-ID: <3fa26fac-5317-4c09-a181-c9c15e124972@kernel.dk>
Date: Thu, 29 Oct 2026 08:28:13 -0600
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/napi: fix list use-after-free on PREEMPT_RT
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Anvik Loitongbam <permissiontogallop@gmail.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 Olivier Langlois <olivier@trillion01.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 stable@vger.kernel.org
References: <20261029102244.141621-1-permissiontogallop@gmail.com>
 <502f31ed-dd70-469c-b433-577ccee36c3f@kernel.dk>
 <20261029094842.58dc252d@gandalf.local.home>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261029094842.58dc252d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/26 7:48 AM, Steven Rostedt wrote:
> On Thu, 29 Oct 2026 07:42:09 -0600
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> I don't think your analysis is fully correct. On PREEMPT_RT, spin_lock()
>> should still be an RCU read side critical section. __rt_spin_lock()
>> calls rcu_read_lock() after taking the rtmutex, and then
>> rt_spin_unlock() drops it at the end. There's even a comment on
>> kfree_rcu() callbacks in there too, it should not be able to run until
>> napi_lock is released, which is post the loop.
> 
> Good point.

If even the preempt rt people can't get this right, that's a little
worrying :)

>> IOW, I think this patch is unnecessary - there's no bug there. The list
>> safe change could be done as a cleanup, but it's not a fix.
> 
> I agree, it should still be applied, but as a clean up and not a fix.

Sure, like I said, as a cleanup. But would need a resend as the
analysis in the commit message is entirely wrong.

-- 
Jens Axboe

