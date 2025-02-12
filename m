Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B40425C6E4
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382768; cv=none; b=G6RSiesnfjj22n/Wo9yeXUKQr1C1sA+nsWmIxWPH1jmXs16HoVFN6rhIzkxPvC2dFyL2qCKgzIwtiYxTGv+Jur0bNx6nAyDWZreBbFttKLNjnM32jFHPPIZITGf5/gYmp7hxN7Pt0zAzCBGckYiaSzUxn/5JpCGvD36Vdg2ifCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382768; c=relaxed/simple;
	bh=56WC7pYL8vor2Oapd7V3UkUIsRX1QwbakQlGQJWbKSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PACNO2V1D9wxu/Ss7VzC9zrrUm5eCE4DxJ77sXthru4QbFUOAOq1CKeXkeS2adI2c6IcWQvwhyeh51873BXx5dGyHPR/2BG+6F7A0DG7fTvUuPs/5ngPMO8hVCHpjnT6Cwlu6xnbGhDv/YxJGKadqVcYWAw8UNpRXJyrI8aEW18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpnxE11m; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpnxE11m"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-308e4bcd978so2361fa.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 09:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739382764; x=1739987564; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C/kS06FLerC2Af3s6b6Rf5nvMZaz+z4sBVLyAweX+ok=;
        b=TpnxE11mgsNs9D3sIjZQAYvL5rUebA9Ou3EAi7R52nFzXXvwU1Z/uIk27N7TmFl2iN
         h5aegn869XPjMfzMnW731uZCHAVhgvzGX+wOxYloq1wQnphJ6xYg+2zBDyDoga618v+j
         aLncqmLmpCIYdfpFHS9gm86Bou4spoa0wavuTssCElHpUyyh+OT+xyb0GL7+FO1IBJSs
         rQDjKmf9ONswENvI2LdFKf8wTb3NVNvnb8TlRdOsGFe5hWYNbIrvSGSa0hkXpRlBbuFh
         YnzSsLKLYsbW7NFYTSzERU6Q8I1EAhyGSXApYesC5g7g30d42DW1sdz7HlMP2X77EB6s
         P/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739382764; x=1739987564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/kS06FLerC2Af3s6b6Rf5nvMZaz+z4sBVLyAweX+ok=;
        b=iT5giKKO3iZCvY0YR8mxSjwaKVAM+PmGrvCoAiTigkVYatKhTdaJQNacSfXZ7j83zX
         UbN6asnUXcVUnf+xtEjgHkg7k4eJsIXQKogWPTDnTzIiv4QA37gt3mTc+7LBTklGiNit
         ZPrW3Jt2LQWlho5Ddh6yZPJzeWcfhvYg4TUjsdlzuwgxcKisezhci4zgjoYPRl0mApgv
         iAFQQNQNe/825mmhy5AB78VUvdyL2x8NEpz1wE9lmUjN+FSTCLF2zpZbHQvZ251VDcD5
         A16O2ul/1Ta6hY4YifU2uP+DbJgNARBLeVhMsJ6beOcl75fIKITPGrGKW1X1kZD8cutb
         STmg==
X-Forwarded-Encrypted: i=1; AJvYcCWatP+/dQAyNfrLuzTCd81/C7D1YdSBeZiEXssSZavX26GaCDyU285rHaGTlSJDauiDj3T7idukxq8S6J3ktg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2TK4wwTmnlQvkcqjvphCuAT5ihS/ylD6bPx39hhAYmc3pyxK0
	wUnv9bgeJQanGgZyMR4ZJiq1wbMYS6DPWqlcNOvGoUDNyRiegx5q
X-Gm-Gg: ASbGncsjy7D0YnesPRc3mnxrqD/weA3yupwAyA7edzIdMq+Hkso0CS+2WSaRRMWES4S
	1MUpf475RynXyVIF32iMMbwczIUz6+2qm9Xg/BipmsQjdh5K/DpTG5JH0CY2K/rYhGGQ+rdtB6n
	dOhN8ejBPUcpkjytx9LQT6vJh14X3X0u57ibW9ppFZoNNNMqhofVOqqC6JI361dI/pfWCPgiO9u
	/VKDCKHuA8j4Snz6Hkq4KDt2kuv2Qwx0y5Qmz7f974L03E64HaEJmoHFQx98FxubjYDiTLlZfjR
	UrMI/QMPI/3Dy8wWEdsnMA==
X-Google-Smtp-Source: AGHT+IGhAf9G/ZHnuARYEZ7FvPVEQiQFkKF3QjpnfizbwNgmuLoZolSmQ9I1VNR6kpuAh/gwQv5YZQ==
X-Received: by 2002:a05:651c:504:b0:302:3356:54e2 with SMTP id 38308e7fff4ca-30904664d33mr5547561fa.10.1739382763893;
        Wed, 12 Feb 2025 09:52:43 -0800 (PST)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-308d9e1fdfcsm15669701fa.31.2025.02.12.09.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 09:52:43 -0800 (PST)
Message-ID: <ef785e05-f52e-4a88-9377-b51b81b228ce@gmail.com>
Date: Wed, 12 Feb 2025 18:52:39 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kasan: Don't call find_vm_area() in RT kernel
To: Waiman Long <llong@redhat.com>
Cc: Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Nico Pache <npache@redhat.com>
References: <20250211160750.1301353-1-longman@redhat.com>
 <CAPAsAGzk4h3B-LNQdedrk=2aRbPoOJeVv_tQF2QPgzwwUvirEw@mail.gmail.com>
 <cfe70f31-e650-4033-9281-baa4cdc40b96@redhat.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <cfe70f31-e650-4033-9281-baa4cdc40b96@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/12/25 2:34 PM, Waiman Long wrote:
> 
> On 2/12/25 6:59 AM, Andrey Ryabinin wrote:
>> On Tue, Feb 11, 2025 at 5:08 PM Waiman Long <longman@redhat.com> wrote:
>>> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
>>> index 3fe77a360f1c..e1ee687966aa 100644
>>> --- a/mm/kasan/report.c
>>> +++ b/mm/kasan/report.c
>>> @@ -398,9 +398,20 @@ static void print_address_description(void *addr, u8 tag,
>>>                  pr_err("\n");
>>>          }
>>>
>>> -       if (is_vmalloc_addr(addr)) {
>>> -               struct vm_struct *va = find_vm_area(addr);
>>> +       if (!is_vmalloc_addr(addr))
>>> +               goto print_page;
>>>
>>> +       /*
>>> +        * RT kernel cannot call find_vm_area() in atomic context.
>>> +        * For !RT kernel, prevent spinlock_t inside raw_spinlock_t warning
>>> +        * by raising wait-type to WAIT_SLEEP.
>>> +        */
>>> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
>>> +               static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_SLEEP);
>>> +               struct vm_struct *va;
>>> +
>>> +               lock_map_acquire_try(&vmalloc_map);
>>> +               va = find_vm_area(addr);
>> Can we hide all this logic behind some function like
>> kasan_find_vm_area() which would return NULL for -rt?
> Sure. We can certainly do that.
>>
>>>                  if (va) {
>>>                          pr_err("The buggy address belongs to the virtual mapping at\n"
>>>                                 " [%px, %px) created by:\n"
>>> @@ -410,8 +421,13 @@ static void print_address_description(void *addr, u8 tag,
>>>
>>>                          page = vmalloc_to_page(addr);
>> Or does vmalloc_to_page() secretly take  some lock somewhere so we
>> need to guard it with this 'vmalloc_map' too?
>> So my suggestion above wouldn't be enough, if that's the case.
> 
> AFAICS, vmalloc_to_page() doesn't seem to take any lock.  Even if it takes another spinlock, it will still be under the vmalloc_map protection until lock_map_release() is called.
> 

I meant to do something like bellow, which would leave vmalloc_to_page() out of vmalloc_map scope.
That's why I raised this question.

---
 mm/kasan/report.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 3fe77a360f1c..f3683215f4ca 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -370,6 +370,20 @@ static inline bool init_task_stack_addr(const void *addr)
 			sizeof(init_thread_union.stack));
 }
 
+static inline struct vm_struct *kasan_find_vm_area(void *addr)
+{
+	static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_SLEEP);
+	struct vm_struct *va;
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		return NULL;
+
+	lock_map_acquire_try(&vmalloc_map);
+	va = find_vm_area(addr);
+	lock_map_release(&vmalloc_map);
+	return va;
+}
+
 static void print_address_description(void *addr, u8 tag,
 				      struct kasan_report_info *info)
 {
@@ -399,8 +413,7 @@ static void print_address_description(void *addr, u8 tag,
 	}
 
 	if (is_vmalloc_addr(addr)) {
-		struct vm_struct *va = find_vm_area(addr);
-
+		struct vm_area *va = kasan_find_vm_area(addr);
 		if (va) {
 			pr_err("The buggy address belongs to the virtual mapping at\n"
 			       " [%px, %px) created by:\n"
-- 
2.45.3


