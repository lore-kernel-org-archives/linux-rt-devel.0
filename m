Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F084B296BD4
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769169924; cv=none; b=oeZ3N0cf8nEHdlI+g7zNWqfoe0lG2FJGgfTiBBSQ/7mE+cBhFRozuSohpgDyIZCqchU+14QbnM8kxJjnEt3wRWW4IuByw3vb+fJS0DNXQ0JFm8qEzkr+nQUkf/4yB8vANYdWSuwzDyIofMJsBAU2dfyFXmMHzxZfKNvLh91mgMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769169924; c=relaxed/simple;
	bh=E2pNtyuE74iPSd0Y58IC2wqLbM2xBKGdvDOp7nlICEc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FwPsUTgUR8A8oVHhpN6qp2rNm6QxyYjbeO7bXOeF3pWjtAtDfereInzVPFZV3zz6icqgYx9ow3/iB+HZkMK0f66nuUtMaIzUY4bkjvgrvEqCfp6keHvGr32NTDt/HBXe7Q9UUT30ZegTy37NQXzjonGHDFE1VM1+IPp1oWt4PMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dyGnt0143zJ46gg;
	Fri, 23 Jan 2026 20:04:50 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 513AB40570;
	Fri, 23 Jan 2026 20:05:19 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Jan
 2026 12:05:18 +0000
Date: Fri, 23 Jan 2026 12:05:17 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: <linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>, "Thomas
 Gleixner" <tglx@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, <linux-cxl@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 16/21] perf/cxlpmu: Replace IRQF_ONESHOT with
 IRQF_NO_THREAD
Message-ID: <20260123120517.00000d58@huawei.com>
In-Reply-To: <20260123113708.416727-17-bigeasy@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
	<20260123113708.416727-17-bigeasy@linutronix.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Fri, 23 Jan 2026 12:37:02 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Passing IRQF_ONESHOT ensures that the interrupt source is masked until
> the secondary (threaded) handler is done. If only a primary handler is
> used then the flag makes no sense because the interrupt can not fire
> (again) while its handler is running.
> The flag also disallows force-threading of the primary handler and the
> irq-core will warn about this.
> 
> The intention here was probably not allowing forced-threading.
> 
> Replace IRQF_ONESHOT with IRQF_NO_THREAD.
> 
I don't think we are that likely to see force-threading on CXL
systems (I could be wrong!), but still good to correct this.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-cxl@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/perf/cxl_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index d094030220bf2..68a54d97d2a8a 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -877,7 +877,7 @@ static int cxl_pmu_probe(struct device *dev)
>  	if (!irq_name)
>  		return -ENOMEM;
>  
> -	rc = devm_request_irq(dev, irq, cxl_pmu_irq, IRQF_SHARED | IRQF_ONESHOT,
> +	rc = devm_request_irq(dev, irq, cxl_pmu_irq, IRQF_SHARED | IRQF_NO_THREAD,
>  			      irq_name, info);
>  	if (rc)
>  		return rc;

