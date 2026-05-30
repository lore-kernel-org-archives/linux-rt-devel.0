Received: from smtpcmd0756.aruba.it (smtpcmd0756.aruba.it [62.149.156.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0196E37F8C2
	for <linux-rt-devel@lists.linux.dev>; Sat, 30 May 2026 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780134818; cv=none; b=DhoKVyM2vc4X3ez7m7dAoXqyQbMGIrwiUj0OXXlaUKtZUkFooxgBCWvYW4mUaF3gyItx6Bzj4cGUJCd3EXnIOHWD3vx5dcUCGHuG2afqkmqjq4wllh3DTFWZDjCKY+N8GAXOvVAJqR7k4sXsSPJKYFurd4EZV2vGL+ZlgllBeBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780134818; c=relaxed/simple;
	bh=5HyOL9IeTubBCnomRKs6n9WOyYq9XGvw/L+X/KbNliI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q34/mIbdm/OJVQuDvFmTZb9/f9fFPSaIuYJGq6ENTz0b/JkIXMZ4prJHLtzVI3F4n7a2vmrIzD5lg9IEWrvVTaZkPJT2LzpHBvMpx6mrXE+8oZ94JzrwHzwurstt7tkqND0JRLELazrW14JBG/j0Fk0kXHlSOogMDje3mbz72do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=Fwa9xuTV; arc=none smtp.client-ip=62.149.156.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="Fwa9xuTV"
Received: from [192.168.0.186] ([109.118.80.246])
	by Aruba SMTP with ESMTPSA
	id TGKlwudjWtpTfTGKlwKfCE; Sat, 30 May 2026 11:50:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1780134624; bh=5HyOL9IeTubBCnomRKs6n9WOyYq9XGvw/L+X/KbNliI=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=Fwa9xuTVYIBquf5GWodh2DjYY3mJMt9tWsBLpfnGSA6xQwYhJqKaIPBIE1DQ/67kx
	 +d63kgrjutEksAs6Xh9bgM8O+PIbSGw0VgNcKHA4hruH+BviTpUE9Pnl0Ko7Wh8ZAO
	 k8LDvu0RqhliHHkpyfYCq2A+vinsHgKxu0V/38+EsuSVuUpoy4ZO6CS9bVu0hg9V6h
	 ogvToa/aFaEgrcnSQLSBPC+1JuzgskmLZ6aDLHEcUYJFXANkTW3inWFHSs/CeBwiHj
	 z7a4hRJRREtPzkT8234QMVIvCLXta/G5DUM9fmCvc9xLWIHJN8M8LnmjIpZcGW0i7f
	 LbNx4skaKdgAA==
Message-ID: <20ed84f3-14d9-4936-b6d1-915ab605b7fa@enneenne.com>
Date: Sat, 30 May 2026 11:50:23 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pps: Don't try to wait for negative timeouts in PPS_FETCH
Content-Language: en-US
To: Calvin Owens <calvin@wbinvd.org>, linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <b5241c09ac0dfb82ee076d06367ac6319471c773.1780071212.git.calvin@wbinvd.org>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <b5241c09ac0dfb82ee076d06367ac6319471c773.1780071212.git.calvin@wbinvd.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfM3Vma0OOrnNijnSbDr8P8mAqCbBHxT79SkBRBlCQgXAxZKToDw+CWvtOyQWlghPzZBUsHh/c2AwNELHWG4z2e7075TDK1ehulGH676kDN83aPSSb0Pg
 nfSH6K0bHm8PB7rO5Gks6x+k+GavLOXboHExWbobPv2EnD8kz9YkIrbCsM0C+v+Ve8fLdVvCLhbjd6ukKYou5t1itPM2K8VX0H3vF5qf+CxCp8xJxW4eebMD
 oVu2LnmcA14dmCf0HHPAxHSyZuLgEdsruvw2R3enY1r5YTAGTbdV35Hsg7F6g2lu0vAOpMeqPw2gvBN33r7lWxl0wvgYNPALMDNWyVNdwX4lro3SxqdPvhux
 LxVHCiA1XlhIdPvrGzPPK4Acv4FijliWvMv2XWjJegFdQEdTnBfvRIrVHwZfErNOUln7P3bU

On 29/05/2026 18:21, Calvin Owens wrote:
> If userspace passes a negative timeout to PPS_FETCH, it triggers a
> kernel splat from schedule_timeout():
> 
>      schedule_timeout: wrong timeout value fffffffffff0bfb4
>      CPU: 17 UID: 0 PID: 4720 Comm: a.out Not tainted 7.1.0-rc5-x86-kvm-00150-g331d97e36b37 #1 PREEMPT_RT
>      Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-20240910_120124-localhost 04/01/2014
>      Call Trace:
>       <TASK>
>       dump_stack_lvl+0x4b/0x70
>       schedule_timeout+0xb7/0xe0
>       pps_cdev_pps_fetch.isra.0+0x93/0x150
>       pps_cdev_ioctl+0x70/0x310
>       __x64_sys_ioctl+0x7b/0xc0
>       do_syscall_64+0xb6/0xfc0
>       entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> Sashiko imagines this to be some sort of security problem, which is
> obviously really silly. But I think it is still worth fixing, so buggy
> userspace code can't trigger the splat.
> 
> Silence the splat by skipping the wait if the ticks count is negative.
> The current behavior is to return -ETIMEDOUT in that case, so keep that
> return value in case any userspace code might rely on it.
> 
> Fixes: eae9d2ba0cfc ("LinuxPPS: core support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/cover.1779733602.git.calvin%40wbinvd.org?part=3
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> ---
>   drivers/pps/pps.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
> index de1122bb69ea..6755901fbdae 100644
> --- a/drivers/pps/pps.c
> +++ b/drivers/pps/pps.c
> @@ -65,17 +65,19 @@ static int pps_cdev_pps_fetch(struct pps_device *pps, struct pps_fdata *fdata)
>   	if (fdata->timeout.flags & PPS_TIME_INVALID)
>   		err = wait_event_interruptible(pps->queue,
>   				ev != pps->last_ev);
>   	else {
> -		unsigned long ticks;
> +		long ticks;
>   
>   		dev_dbg(&pps->dev, "timeout %lld.%09d\n",
>   				(long long) fdata->timeout.sec,
>   				fdata->timeout.nsec);
>   		ticks = fdata->timeout.sec * HZ;
>   		ticks += fdata->timeout.nsec / (NSEC_PER_SEC / HZ);
>   
> -		if (ticks != 0) {
> +		if (ticks < 0) {
> +			return -ETIMEDOUT;
> +		} else if (ticks > 0) {
>   			err = wait_event_interruptible_timeout(
>   					pps->queue,
>   					ev != pps->last_ev,
>   					ticks);

Should the problem originate from user-space data, I deem it more appropriate to 
verify them directly, rather than relying on computed data.

	unsigned long ticks;

	if (fdata->timeout.sec < 0 || fdata->timeout.nsec < 0)
		return -ETIMEDOUT;

	dev_dbg(&pps->dev, "timeout %lld.%09d\n",
			(long long) fdata->timeout.sec,
			fdata->timeout.nsec);
		
	ticks = fdata->timeout.sec * HZ;
	ticks += fdata->timeout.nsec / (NSEC_PER_SEC / HZ);

	if (ticks > 0) {

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming
