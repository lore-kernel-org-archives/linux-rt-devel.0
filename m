Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519782BEC4A
	for <linux-rt-devel@lists.linux.dev>; Tue, 22 Jul 2025 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753170834; cv=none; b=CcuGECJu5B3SV97zwEjibXdwkM9tTmxf/nrZKGZCl3JnwfV0j6fS+i+PgZJBbNeFX2845AkzLDOms8eJ8VOp4IvpjgMdAm7LrrAiI0ffeEhVF8A67te9/Z9HYMfaZMPP389mhicEJIkQuc/x/o6XwOFMHyTODUa60Of7bnYSgKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753170834; c=relaxed/simple;
	bh=LvEhH1A6Dwx3H/5INeeHeEgiquLdi0o4ez7HR52K0KQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snDcKvEP+Bt47Q9PVmTvFK5bLkOsBmVkVbO46njR86uwlcXxO//E+a+IMCHZ+BrRCyGsP7ncc8kPcty7ebWY2PRR4sEHoCFDuizCSEzvYOhhfrhKzStDNavpAZ0OGfo8UV2s0us9iyFp029AktbzX09xmNyDuEU6dPUu8ndD3WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jetJyM5O; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jetJyM5O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753170833; x=1784706833;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LvEhH1A6Dwx3H/5INeeHeEgiquLdi0o4ez7HR52K0KQ=;
  b=jetJyM5OIXGmapwAXgbKk5T2AidZcZXUxX5WoNqtul2UMZccPlDqfk4N
   Zhe6iolaTbsbABXZj04MbAYQ++WfG/Xyv5Cfg0cSZmyPy2LmXhxgWkP8r
   2HMqAWXKw7tNpdAsf+9XX8QpHWkheESGXVQUaSX1JX/oLAqDYy41fVJBw
   otgLgFleck0whRyt08E+e/yQI6EHcRrIkco0M+6zwwbJ49ULYx+guyfP3
   MBLqx/045Zj/XFbvdmBdc52G5twbL+DBoDu0UmnEb6nOsKoJX9Eotmth2
   Vmbth3EHgVbyKx81VlyUv6yW67DTJDlLr6/V0Ks2Yif+rO1669rc6CMfe
   Q==;
X-CSE-ConnectionGUID: zoVjHhkdTIy8NRsejikTIQ==
X-CSE-MsgGUID: 2ZEToaaySgSwFu02WE7Wqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55556847"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="55556847"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 00:53:52 -0700
X-CSE-ConnectionGUID: WWaCzABEQKahnLI8UEuS9Q==
X-CSE-MsgGUID: fEILP3QARfilWvfcjIBU0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="159154782"
Received: from wdziedzi-mobl.ger.corp.intel.com (HELO [10.245.113.213]) ([10.245.113.213])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 00:53:49 -0700
Message-ID: <f14e9187-e3b1-494d-b04f-9e7875a17e5a@linux.intel.com>
Date: Tue, 22 Jul 2025 09:53:46 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Remove lockdep_assert_irqs_disabled()
To: Maarten Lankhorst <dev@lankhorst.se>,
 Maciej Falkowski <maciej.falkowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20250715165919.33754-1-dev@lankhorst.se>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20250715165919.33754-1-dev@lankhorst.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

On 7/15/2025 6:59 PM, Maarten Lankhorst wrote:
> This breaks on PREEMPT_RT, and should be unneeded since
> lockdep can track irq disabled status itself.
> 
> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
> ---
>  drivers/accel/ivpu/ivpu_ipc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
> index 39f83225c1815..5f00809d448af 100644
> --- a/drivers/accel/ivpu/ivpu_ipc.c
> +++ b/drivers/accel/ivpu/ivpu_ipc.c
> @@ -141,7 +141,6 @@ ivpu_ipc_rx_msg_add(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
>  	struct ivpu_ipc_rx_msg *rx_msg;
>  
>  	lockdep_assert_held(&ipc->cons_lock);
> -	lockdep_assert_irqs_disabled();
>  
>  	rx_msg = kzalloc(sizeof(*rx_msg), GFP_ATOMIC);
>  	if (!rx_msg) {

