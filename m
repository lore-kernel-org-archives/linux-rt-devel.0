Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49142D8DB5
	for <linux-rt-devel@lists.linux.dev>; Fri,  4 Jul 2025 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751632922; cv=none; b=t/zp4REs/ddwfU5K23sgdgku4ZkO6ktNzPtDnwyMHUCbxl4KWPYc/Vs4tgtqk6nfKocBqLlCNSS3HWDBs6o2IUwkKa9AnDZeDHdDsj43ImoLfMdDERqW8VYJ/HGwtAzmcdpOCZ7IcW5WOFX8FjujF6zROxtMtevt/zJf4wjCXx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751632922; c=relaxed/simple;
	bh=kGtEV2cuH6b/oHVSRFuKI7/mizHhpicF4X8A2aYvW0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LkDTF/05esRuzVo+xDTTXIxuE7uo5OkLRtrspZCBZPloJHGgyMOPkXdjegQso3cPTK+C8a0pQdzRelVn4jBQATJq+vYYIvcEZOzie4dfYR2fDh8dCxybpJyQgMl8mOCWg6p2zlkcu0bYRv+KzRndgTtr5OH39HwFCamml+nvgw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ds5GeDQ2; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ds5GeDQ2"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32b4c37ebf3so2112131fa.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 04 Jul 2025 05:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751632919; x=1752237719; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xd/Gd4g9iL4ksrRFBiW3o7hZmTHOxsax9CgkAVFFH9A=;
        b=ds5GeDQ2puiHfuKIr+FPaicYd1NUw8vYGizTFpzk3+TkRkvVkBWuFNUh3KoASy2H3M
         qrONvjHoQS+bFZWOB1gK964zf6dFXT+dH4940T91TQNP09z4uQ40y+fEjl36v49fldjQ
         Hk07Dl89AHZ+IEfDnnsTjNe/KiIG4cbGxVnMVgHeHvPq7Ap3++C5BbIw1y4nRjM+dvcc
         jihc2LIF1Hp0WW18rZ/SgcJgmxb6yqR4XaTVPLisFtgHQ6qfggxDRGJpIs23IyuR8v+x
         dLBtr9bKLO2dGsKOuS4rRCVsC2beIXb2k79ol5MHhIZR9qXuDSx1FH0YjvSqtE8VPIKF
         8h9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751632919; x=1752237719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xd/Gd4g9iL4ksrRFBiW3o7hZmTHOxsax9CgkAVFFH9A=;
        b=X7oe1haZ4jEKBeDmFvX08bO8oWPMRAKvyOzwmiFYQ6Nv8g0GCdZdu/4y/CQKRuwQM4
         flcisnTWhxCVwQOLHnr3G1nF8nBWVVOzqXxXv7kYeMQ8UqIrg8Avk200kp+IE+JewksK
         4bDxP3B+YZZVrM/cedLdQ2x8e17VSH1hIftqBx/so/bNHYIUk2LZJi0rg1sjPzqJDKAx
         8hEhnwynaVeAEmEqrcnVw7T3avp+Wekm+NAQ6JAPMYBjTveFSWDE1VetcEhFuSv5JWE2
         PXvVgPKz65jUOs4PFB3FHNiKv2oJ0oqiPIJXP5aFW+XaD21BM6v7Fh+TP3U5DhaxAyu5
         TMQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1QkFuquDr72o06K8AbmCuqdEszS2WmlXGyEGzgRNvI+nWmN47G+b7162tabL3mZOc6YxHc9hNjLMnc60+Lg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQNnVsWgMgt6M2IRbXP8X+0W7ytFYzaTxRGAzspGUT6c2mcqpm
	6Q/5l2u5rXwg+8AHC/xTln7o7BBg9arPW8gm+qCjsVkYPM9stgviC+/z
X-Gm-Gg: ASbGnctdkbXW4lstawSzz5dk22JUmBNjjGxDxg7skR0J0Jos0x8wkFSLau3AnnLlW9j
	BaZGztaQbgzfsNmij6WRF5VUJ8UPeaS9nN8bkqfl6p3P0xT5n5mHnsqX7g47UXQ1dEtU2aXQB9v
	yYF1DrRO2wB7oeJDTv32v3KvxztMMC6yJR1BWfL3JvK0zqFyKkx+ALSuIN9ZIfKnLFF6eQdlpR2
	5AjMtxicCqHuS8Dh7Bekw4W5tuA3rBuHGP/VNOXVyI018gC9VZVg1LpdTrkiWJLaPVkfxRpMSM2
	Xgz9c6m6DeFZh55hAQw9Q8/PANDw2VlQB5KO6q3RoFluSf8qvegNXRTFSUWkh7qCvsZ5
X-Google-Smtp-Source: AGHT+IFpR+kqHcRCowqKxD/zKWbNA1bImZ4/UaRb9kZ2c/jW1iKS5nfu++9PfLMSuf444Ocbqa70pQ==
X-Received: by 2002:a2e:bc14:0:b0:328:109e:f974 with SMTP id 38308e7fff4ca-32e5f5b7630mr2452791fa.10.1751632918553;
        Fri, 04 Jul 2025 05:41:58 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32e1afc362bsm2090351fa.36.2025.07.04.05.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 05:41:57 -0700 (PDT)
Message-ID: <37b96f5f-d79e-47bd-9616-b6c8905bc984@gmail.com>
Date: Fri, 4 Jul 2025 14:40:39 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kasan: remove kasan_find_vm_area() to prevent possible
 deadlock
To: Yeoreum Yun <yeoreum.yun@arm.com>, glider@google.com,
 andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com,
 akpm@linux-foundation.org, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, byungchul@sk.com, max.byungchul.park@gmail.com,
 ysk@kzalloc.com
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20250703181018.580833-1-yeoreum.yun@arm.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250703181018.580833-1-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/3/25 8:10 PM, Yeoreum Yun wrote:
> find_vm_area() couldn't be called in atomic_context.
> If find_vm_area() is called to reports vm area information,
> kasan can trigger deadlock like:
> 
> CPU0                                CPU1
> vmalloc();
>  alloc_vmap_area();
>   spin_lock(&vn->busy.lock)
>                                     spin_lock_bh(&some_lock);
>    <interrupt occurs>
>    <in softirq>
>    spin_lock(&some_lock);
>                                     <access invalid address>
>                                     kasan_report();
>                                      print_report();
>                                       print_address_description();
>                                        kasan_find_vm_area();
>                                         find_vm_area();
>                                          spin_lock(&vn->busy.lock) // deadlock!
> 
> To prevent possible deadlock while kasan reports, remove kasan_find_vm_area().
> 
> Fixes: c056a364e954 ("kasan: print virtual mapping info in reports")
> Reported-by: Yunseong Kim <ysk@kzalloc.com>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>

Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
