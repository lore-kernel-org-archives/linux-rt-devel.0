Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582681;
	b=nS9pziTBiy3f+cydMDVgxQwjZXyF3aWNM6NDcWEJELJAbxVr2Z64HK/yXSt4Z4E9psMM
	 V69Ubbd7hk3BNN5oMGyg6o2ZUblFME2TiX2KXhqNVXeLffTEDoFasbjOBv4IpZv2cUJsm
	 u8J3ae0kFQdCLKyMOJuip8F7Pj8VIbXuepVc0orM/FOxfx11SSd2HFNOq4xC4T++6q0/a
	 ZIvy63nIJ4H+UBnE0UbA99IzB8JfBBQCc2IZnWymzsadwkpFTbfMvK9O1IjQegpr0VAyV
	 9yaLmF4oTdM0O1VS+8dBOLzIYStwIppymWoWmXuvOy0+1eera2uEx1ljaWS3XqbiK6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=anu/2F6mroicCWt3l+8C2jxZSamPe+b0q+OPEpgFtcQ=;
	b=JsyT+TrgnL4v35zvM91QggLynSLh6J/QqyVpVA+1Q5+kC1alMN5VZ7VrMgzZM7eEpWOi
	 mj911LG6MeSHcbJt5G2D90XBdifDtJMDLN8eOSYYgRVgT7j9qPxw+hUhMYeHBZamOf8Pu
	 ElqRkkp/xBZdghKT7cGjA6wFno+Xwr2RmnrBCSJZN3EK7S3okZo9yECO45eVIXLmNqtOG
	 P6ojUTJC4c+DSrzuqKXFY6aDNxppZHmxtOlItcyLZ7sR1N2FAiYcWvcAhPzq7dQsT4tdw
	 yijnDs8rXbkF3zi6RRe49s1H2aN/A7Az38YfRjRkJIx4V2ILzyPKNJlTS6ZvgL7UqGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="k9QSuc/N";
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4425F606A331
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 15:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4425F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k9QSuc/N
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5eac01ff101so393203e0c.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 07:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794582680; x=1795187480; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=anu/2F6mroicCWt3l+8C2jxZSamPe+b0q+OPEpgFtcQ=;
        b=k9QSuc/NPKf8baf/xcBDQrZcxhV35DQIvLevK6Sljk+iWh5UE0jUA8YREpJAQs9Bej
         cM2B8DygF4DEXH+1TmvH1lQxDR4D5G16oNAfNfhEjroV8+iY/a3Kcwe/xoeN56yEA0EQ
         FLV71R6E00HcEZHIF9E4DNCCgGa+6Hjnj1pXcGmeRoRELGhu1TS79sOtal+5YC2iV0fB
         9S00nkNGzedgCrcTl4RlYjrHyiGpidkEjnyeuZ9G4sZ27UYWAF9KFa5X1xTwTaK3ET0z
         4Vx6Mb62gZk6OEwlpaP/0+4Chmj8NBulSnhlQmbfJCWmg7RqO/A0QhOYk/Pm0h3XzcG7
         FrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794582680; x=1795187480;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=anu/2F6mroicCWt3l+8C2jxZSamPe+b0q+OPEpgFtcQ=;
        b=F7v1LrWkRaqWUA/UXr+vYrChzOmlrP6EuErsRKir3ABbU7ZUt0Dj2FlJx+VVdZNPxI
         zx+WM1bZtX1uy0dYp5i3L+CwdGE0TmJe6m8GkkHDZBmCsIW8Ht4fx2QN3t00vAeB93c2
         Xj8XYs87BshHR6CQ0ag+/ZSH13uqIGO6vaFDja7lFryxbRz7uFN/AGIrLJhiKgolOYf9
         y9TN14xqtMEV4UQPzU1WdnhrYWHnJkn5F72mZ5NYY7qfmRanJyNMmcfgUxqqEdPXJL3V
         DVEhMy9U8mnKW8CxfnUBrR1NS00nUKtTsJ0oS3oVRmzs+BMTeF4qfWxCq3TB3yTjCBZt
         ZWuA==
X-Forwarded-Encrypted: i=1; AL+hErFlnUpVDmesqBrPRZ9hXr6bFyt8MQOIDJ9aFxZCtFH9SNRUAqK93egNn740sFlSomb430gdsqCM4u0je4Z4mg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+YIUAMVaXjahqx5rHZrxqx70MZ45vzv6mA9HENcaggWhkxJ5DX
	DzxJKBHG68R8foidsyHqjtKy2Y+Z03HX07xEZ8huE3HQstPmU58JOqe8
X-Gm-Gg: AYBFou3EPCruZX4euB16iDGWyFK2kxpKhDfmFT0bnjRPcnGMNVNrwbIpVqWPEBOKVfE
	A/OpRzDxGWt/wz+GffnlUx27Q0ErmYNpfOh+W2H5CGwA2g4LWq+Nhdn4d8uqb071r9uuHRGipJp
	p/JesDB0HBkcJld0ENVKFMshjn0GMXQ7SQWzbiR6MZfw1DWx4vIJ9cXNrMWrminBt9YEh+XV5u2
	H/Sz2n3KbVCTsnDWL5te/o6OqI7J/XP8JByX9gKTOS9yv7MTd8SOaAj8Nl5PQcg/gKGfOd4OIiI
	fJjmQl1W70SwHB/Y2zqbcWIEnrlO+Yscq0LH3+/UmQsKFHMoOMh8UXT/yAtM14hO5cEF11pl+JE
	EcyItaI4b6SG2YYVRpuDKCF0UrZkkH91QuEwUV+j8FXy6myq2qAafmQ9GVB0qEvybQgASsa8jyj
	mzlxwpJss4JGrkIKOhpQ79hn7iGiqyg+eYno7zXiEYjqRoETdnApif/wH0ViPneb9D4TcNYblWw
	rz5oT62DUKUu2UPZJie+jzYWD6SIdKIn4lgUNIqPuFzoSsSV9P39A7Z8eEeIVpq1tm6av2uTrQf
	j5QXdVBvouPG4mIu/2wtDN/pZ6qV/E42TOjeCTzy/TzE3oxmyhMvn4gmLzExJ0i7cB3WUFU8Vin
	dBWItxAaDMHZlsEyWwViHV0D7jPJaTWdIrGE2fzOiq1FBsfRXTzutAKSzCvp9zSk+ROMqriGoS2
	refbxW6c/2
X-Received: by 2002:a05:6122:1816:b0:5c9:a60b:e5c0 with SMTP id 71dfb90a1353d-5ee34aaf4ffmr865841e0c.16.1794582679986;
        Fri, 13 Nov 2026 07:11:19 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e32f83sm1472842e0c.6.2026.11.13.07.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:11:19 -0800 (PST)
Date: Fri, 13 Nov 2026 10:11:18 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jingxuan Xie <jingxuanxie@deeproute.ai>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 =?UTF-8?B?6Z+p5bCR6Ziz?= <shaoyanghan@deeproute.ai>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev
Message-ID: <willemdebruijn.kernel.3a16e755c0d38@gmail.com>
In-Reply-To: <20261113023809.24730-1-jingxuanxie@deeproute.ai>
References: <20261113023809.24730-1-jingxuanxie@deeproute.ai>
Subject: Re: [PATCH net v5] af_packet: avoid waiting for TPACKET_V3 copies at
 retirement
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jingxuan Xie wrote:
> TPACKET_V3 retires a full or expired block while holding
> sk_receive_queue.lock. prb_retire_current_block() takes
> blk_fill_in_prog_lock for write to wait for in-flight skb_copy_bits()
> before publishing the block.
> 
> On PREEMPT_RT a read lock can be held by a task that has been
> preempted or is running on another CPU. The packet path or the
> retirement timer then blocks on the write lock while holding
> sk_receive_queue.lock, and the receive path resumes only after the
> copy completes. This was observed as a receive stall of hundreds of
> milliseconds in a PREEMPT_RT deployment; manual inspection found the
> same unconditional write_lock() in both the full-block and the timer
> retirement paths.
> 
> Try to take the write lock without blocking on PREEMPT_RT. If a copy
> is still in progress, leave the current block and its metadata
> untouched:
> 
> - the retirement timer re-arms itself and retries after the configured
>   interval;
> 
> - packet allocation returns NULL, so tpacket_rcv() drops this capture
>   record and accounts it in tp_drops, while the original packet remains
>   in the network stack;
> 
> - a later packet can retire the block once the copier has finished.
> 
> Do not dispatch the next block while the current block is still open.
> The existing lock order and completion ordering are preserved, and no
> new state or worker is introduced. The trade-off is a higher capture
> drop rate while a copy is in progress; original traffic is unaffected.
> 
> Non-PREEMPT_RT kernels keep the unconditional write_lock(): there
> read_lock() disables preemption, so the writer only waits for the copy
> to finish, not for a scheduled-out task to run again.
> 
> The stall was reproduced on QEMU arm64 SMP PREEMPT_RT by delaying a
> copier after frame reservation: without this change the next sender
> blocks until the copier is released, with this change only that
> capture record is dropped.
> 
> Fixes: 632ca50f2cbd ("af_packet: TPACKET_V3: replace busy-wait loop")
> Signed-off-by: Jingxuan Xie <jingxuanxie@deeproute.ai>

Reviewed-by: Willem de Bruijn <willemb@google.com>
