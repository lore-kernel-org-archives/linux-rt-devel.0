Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792DC175D53
	for <linux-rt-devel@lists.linux.dev>; Fri,  5 Jun 2026 07:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643533; cv=none; b=dh5CS1wKZO5dp4GH2XrFjeg1DezQxyxjVuOyt5o6L9tPiRs22Penry74K7E426KHCDec4ZkbbOatGmkX5BEatddkkHq6KPhm32vk79KtJhSfeZpouw2/AnNFlBm5hHsaSa3JOK7kOKebTLUJ7rl0jxJSzDAHlFr5Ox7eE+zZxk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643533; c=relaxed/simple;
	bh=LTLQc7ME7J7eUP93Wq//rFEEyGgeOk62Srx02OHipjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JYt2UrSTslwtoKe4TqrEpqI6896NS7zPvlbJNm5/Asa/kAL8wd5EJYb1MwdYkoe2FaWsNUdfQ9mpuhkMa1JkqpO8PFid0f6L5WmP8aUyDMesu6VGbhJrpvy5W8fg3QtC2YXWKSXZwdcLDTBs5IME07PZqNkSgXuFq3ZDz/UOyAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/qSrpMv; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/qSrpMv"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45fd464d51fso865699f8f.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 05 Jun 2026 00:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780643531; x=1781248331; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ayZZoFINc62/YbxwsJhIjKy4nCpiHkUbwPnuNcQomCM=;
        b=s/qSrpMv5SZEym2qAe7qybQqjl34MNnhNNqw0olQaqlnLdnAwhgqS3iRBCz1P3vmZX
         ULyhbhagfYSxbJJ1VN5mSf3X01q6BOST069qn4rM/iET0nVXVYCWBzen893B4ekkmLXy
         +aCY9cfgvmEAiBwQQFlPUcNKhU87FhxFCa2zLvF+ryeJXyXXP4Uq8PyqjwDsNM3QQugT
         /PrzxeW0kSm3pFIiaKtzerhZMz1vKy95DzNS0J/HJsxx0Pk/Oqiy78mW/qwKgrNcvF4f
         e8shzM9+kd/futQTu0p2qNtSeZyjfpr4gLH2RiG5gaRGvz0xw0Ks6dGaTMfby/pAPE0t
         lxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780643531; x=1781248331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayZZoFINc62/YbxwsJhIjKy4nCpiHkUbwPnuNcQomCM=;
        b=ApsLPJE/g/I4pG3WbJiIZde2+5A5eMoLNZMXLMcGSEKXaPU/0cZwPkQ9/Z3AqfyXnO
         xIG7PLkdoVlwmR7PuKcdnweJ7C9EB6ewX5KzuDeedoGO6TR7FZc7chJDLRbQYWPn3qJF
         pigqPngG0H3bLKGOIvDYlLaINGGwPACwJI702n7yA5piSrfM0YRyy/LSHW0wIjslXvTn
         DkvH+/15n1qONQp2NcAPFb+VjRU4pKJyK9/OvICSW4Jfk0yJFqy4tAOtFdLPt/bnZ7R6
         4rmUy8BQXjQjNmxxXiGDobrrME23JTiIBSiLK9USnIXIMFkhIlXLkcXd41HoG2DyRrzn
         wSsA==
X-Forwarded-Encrypted: i=1; AFNElJ+DDvrhsPpH3qfOQMFp14xdAQmJFwPzcsCn1foKFj0llZkzB9tJGIP0Ub7gNULjbjnS1hAj3o+z8bsdxOqYug==@lists.linux.dev
X-Gm-Message-State: AOJu0YyyNQZ6WP813+qBbxR5dvg+xUKUOZFeAIKevhPWqIMOa5ri6sTb
	ir7qs7ywRQn7k2yQ2w9D7QaupGS+GwIybkNz7lkIT9bt2WIbAfSKQVke
X-Gm-Gg: Acq92OFDyyk8BTJdE9ByXCcnNGnK79ljem9xZefF5k2k2fCraCRh3i1QTt4qpN07ZH0
	gweVrcYdRMLsylEbSlfnYZfShpmKGl+5oqLNU/4OSzue++k7H9m7GeAjgjvAKGaAIDgma+eY7n0
	JY2jwfosIh+FxYXQnwpP10U4vLdT2A0EAUi3F3WgygC9b9mdj9d8p0b8IGwekrJdHUve2IEzalj
	02x8P4/CaBBVCmmz2OwvzQ/iiIU5O8fOIKeKRqzWcNLBsz/rYjJQDcm2I8/z7Q2N1U6TkLtrlLM
	vy0ElWE1jAXaZM0WdZGyQ2uG+wzdAZzF6dWVdsQ0Qh5/+QGOdRQVvRQSE/UUjyTyeRqUqkZIP3x
	/lQrmgUvzTEUrrGOwRTXX5gqThRnqDft0Dpwso8Q20E5lAkALzemUU3Cg9q2fbchx0JbmTOi2Ue
	vbWlPotcocVce9PYbHq2EkDXtZAgyyEGqplN0EKYeSgzE+q2AgA8xFt9Fjhc4jP/Fu4WMulOlM8
	5gY4AckNPH2PJuLc1G6qRd5brbukM0xIxJ7iDrdqKTD/bo=
X-Received: by 2002:a5d:4e09:0:b0:45e:ea68:523e with SMTP id ffacd0b85a97d-460304fe066mr2960398f8f.21.1780643530812;
        Fri, 05 Jun 2026 00:12:10 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f133:a901:840b:2bf2:919c:cec5? ([2001:9e8:f133:a901:840b:2bf2:919c:cec5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f5612sm22213455f8f.15.2026.06.05.00.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 00:12:10 -0700 (PDT)
Message-ID: <02b1e77e-5b7e-41cb-95b6-731ed00d9e74@gmail.com>
Date: Fri, 5 Jun 2026 09:12:09 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MIPS: smp: report dying CPU to RCU in stop_this_cpu()
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260604182407.3109536-1-jelonek.jonas@gmail.com>
 <20260605064250.q0aRKkon@linutronix.de>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260605064250.q0aRKkon@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Sebastian,

I'm not an expert in this area so please correct me if some claim or
explanation is wrong.

On 05.06.26 08:42, Sebastian Andrzej Siewior wrote:
> On 2026-06-04 18:24:07 [+0000], Jonas Jelonek wrote:
> …
>> This issue popped up during kernel bump downstream in OpenWrt from
>> 6.18.33 to 6.18.34, since the suspected change has been backported to
>> 6.18 stable branch [1].
> I would avoid the link and simply write after the backport of the patch
> or so.

Fine with that, I can adjust that in a v2.

>> Call rcutree_report_cpu_dead() once interrupts are disabled, mirroring the
>> generic CPU-hotplug offline path (and arm64's stop handling), so RCU stops
>> waiting on the parked CPUs and grace periods can still complete.
> This is part of cpuhp_report_idle_dead(). Is it now invoked twice? Or is
> something else missing/ different? 

Those seem to be two different paths. To be honest I'm not confident
under which circumstances which of those paths is used to take down
a CPU. In my case, issuing a reboot command reaches smp_send_stop()
where the issue explained in the patch message then happens.

> Sebastian

Best,
Jonas
