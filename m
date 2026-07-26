Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E34348C76
	for <linux-rt-devel@lists.linux.dev>; Sun, 26 Jul 2026 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785091665; cv=none; b=OWTWmESVZFgJWWrD3Nd9aKPCxM1G7VyqC25ydfhfq1Rlzf+9SDvwrQOX9zu67sTu/ebEzJpoHjwmqrsJjR6qsSfiaXLgAYyWsv69afxqEFG4+HJxZ95F31zZl/4EIVu4S/Fvq3ViyT2XN0LKz3SeD6sLLMgaJ4QBCr4GZIyNfuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785091665; c=relaxed/simple;
	bh=vUI52GVPzWOowxMeu7eibQEBZZZhJHi7GKhPHWuQLpo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G+Do86xh9KnD0TJVzAQZIdoHj9kgD+XsV+pudCQU4rMaCypmYXqttSFAmm3m/GYSwNr0W/tLKkIXiXi/y9D4F5l+gTTSDxCycJykE0TrD9/Bux+zQ9+bm1Shl+eQ09VcBUCFmeAWjr9urwoVM4ZJ7t+PqHzM3ofdocbqMCgXOJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=T+Owhq/m; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="T+Owhq/m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785091630; x=1785696430; i=spasswolf@web.de;
	bh=Aqmbbgu1T1ebnGSZeQPc3+cep9OLWmYPVOjF/7Pt5xA=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=T+Owhq/mbcCQUTTfHWJveUg5RwgRDccIWYRYgXJx08DeIFLSO2ImKXnppDK9uQYC
	 GXDrdzdC7KPvbQ3DrpYyx5/Xgyh8o1mGJlwza6WBEvGcxiXOJSmyk2DQTt8wT5jJi
	 8fI+hgP8y4H0vRfcl0bBOkxlJHuNozFo7PNdV/MA5+6TrA1XAPNeoxSOvCVoqLxpx
	 /OUs3arlwdo3Qh0TM2G1hwKxi3FGyGXqMI2Am3L2PI+atd92sZqxfOz3l1h91E+OB
	 k9/4bvF/KBNkeffMrUbGgGuk/5Sh2t+l/jLkQ6dMNYAzvFUnthU1nHE3GZtceOMKP
	 NDUoGFZ+ZmU+oQwMQw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MtPvg-1x6HY020vG-010iap; Sun, 26
 Jul 2026 20:47:10 +0200
Message-ID: <6e0b713cffd64b3c30eb4ff04e50721bac9cf8ca.camel@web.de>
Subject: Re: [Re] kernel panic during shutdown in  next-20260722
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org, Rafal Ostrowski <rafal.ostrowski@amd.com>
Cc: linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Thomas Gleixner	 <tglx@linutronix.de>,
 spasswolf@web.de
Date: Sun, 26 Jul 2026 20:47:09 +0200
In-Reply-To: <4af8467060c5ee136c2b99ab855a007fec4e8c6c.camel@web.de>
References: <20260723131001.11565-1-spasswolf@web.de>
									 <d24a136539c5931984f4855ad6596ca7aee8ebe2.camel@web.de>
							 <1a0800888c2fcd42f1fcd661d8f6f50580ac2fd4.camel@web.de>
						 <4d7c2dd588cd77d1d112da473f2a262d22051d57.camel@web.de>
					 <3c1be47abfcc907e7c1f9696cb25a24c93415a28.camel@web.de>
				 <dc5f1cfb267b0fb522b8aaa236b71b23e236df4d.camel@web.de>
			 <4af8467060c5ee136c2b99ab855a007fec4e8c6c.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wVAqCoZn4Gi8PJgRVM8sbSlA54saRLJELOqSsdxSO1lxdTG6rYA
 1XaORD41gXu++FXm07shQSbCkCbhcbPfSvyzG01nvax166M4RyBzJFFcIN5w3QeUfNDQfXU
 w/SPGCphNYSPddGydmUI+ugWMVg4vjyt8ZVTUYskR3x/U/U+6Z3dRDdGMHWpM6mesIuU5rP
 RnQyyi0lz/FZu6C4s713w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/18SHGwBdBY=;AjRvfMvweBT+e5A1h1ayuOXI4Ti
 O0qlsXvcXlVl7ky9ISVXO38k0rtFm8eYBUQyRudxksVt2VIjwx2O/X0ySYUQiy8UIzPxo2Sxw
 fEiyaOMUe/npOoQfAn8ONk7T1795tIT0YdIfmi9lyY8KyXRozIm2PVf9txzHxgxbjJbjgXT6O
 3D1fo/0qtiVZtOdgMOabE7DbBmkEzn52PB5fqhnAGb6tpV6gL+v4eWnBq+MQn/F3LgiopC0La
 HYXLcTu0SyWZzx/gwrOh7QiXKAqFjVe40dnK6q+efhirYDGdaT1xjnTo2BGvWz0o+6Np1eDFs
 +S4My1Z5hI0Osj6Q3eoFA6fA73e3LtfkNm1RyWPj3vl90u3awHUIVM88GlC+M+HH/q4hYtokL
 6Tlfwak053TxozbGTUS0vhwyRtf2Bq71GEDAOHuamiD/hYwNaKXOhwC9HUWAd/3tkt8xDANbN
 PxZrG1cg/HnUX/JHtAafEAizpLIrr06zSTWllWUnLWGYnp1sBw4Z3nuZ2OAJtuDYrdXBhNfFV
 TLe1bcdDbCrkzwAlgoeuZh+qv0DI93yVs+hvLiz9OGXCZeu2ShHRZOJx4VD1pcSiT9caF7ssO
 hF1XmK7/q07OEBGYWDc7rFq6RNMkGN6z6tfFUYmByESM9jx2Bx3KCgUFhPq79uDy+KQ5IMCur
 pGVePVkUW9rwEGprxOK6xoWoHNsduIrpyOmmXQOlg73FZl/5rca0txC2E6YYgTbnlBjnvaFou
 zOFg9Pm1qKriAcZuIZa6xbdkPhHyqfYAo4vbIXFWs2RxzMw+t4x4eiYRYseeb0cMBk2McwuYU
 mpXz1w6LR5TlbTtAZNi99KKwGTBlzfRwYeL86rL/8fxlLMEedTCCpKqAnU0LDoO8j00THVX5N
 3EP1OZXVIa6PeC8A6spFXrV49Df2ZQkcQY+sJklZMH0FMU7Jfm/S1HHtqZg18ojjZaqVD6zny
 YMqIcyO1L8iCGkQEcvC8ToknI0NT1sAMiBCzALJoiE+UrJ0RwitkY9VDXKFPPXDm+7xYJJ8uo
 1WDGFvDXMHHzbRoDVyAlniaapjC+yDrEfPvM139BtAroaOZ5wMHSrLr4N7G48Udyk+q/v2NQB
 fBr9pViOxDyKo/NK3i/QF1iC6nctr8n2LO3VDGNOfiCnYY9JNN6CJ9eUJFq8aLZYKMCmkoUlq
 j9dw7lZn9CRsIkry/czNz4GIftSvGiu7NC638gsSNw7VWVJpIyLSitc6uDYsR1qF9KqNElCES
 HVdToKy3UToIXq8fy20FhHuPUClVuApDSfEINDPBRabYjWA8BW2LgDwqtl0jEdxuTdm1B9jZS
 bqghLdMlq1ztU2H4yQpkQJSvglZDcWSQ8Gswc+AbUfEDZ6s7OndR+KxXLoRKWxCAqFOGNkCcI
 bvd+Cvt4WBD3n89wp6NmKO0Dc2InI6UOWuJLth2/0NokChZRNC4CrqMK9UmqVK+V34CjXl4lj
 Zyzvni+ftWbED9DSRj8XUBaHiFrIaoNsLEIR7ARQ4orkZU5DZaJP31DZ/CkCERRpqxIVdueca
 00qscLyivEYGep5ie6uT5MIJDtp6RS42fMHL4nfVAhYF8niVvVxbf6RkG7GUb6RSHP6P/FkU/
 VbTb0OqFTz+2Gqi/+pb0AyC5jjYQ2cLqTN7TvUjbSqfLc0y9f7dCIS0Nf5t20UVkPff9ZEPPl
 t254QbsYJNh4QqPbBF0J3s5aarxLDcdPlSw/eB6AE/ZQvqANB0ye4MXNA0tZhrzjWsUuC8eFA
 3Jj6IcP+eDkyG3N4bOpaMacvWXCRmQ0TWngXKOPgPYbeR7WhEcrLCIMm8SPIx37FX5UzSRgl7
 7CfK79OvxA1PMyrqv0SfT3sxDPYViGVefID+2bNvuRG46anr7u5tnS1jxLUP/nYlHS7knn5pS
 3z2LPN4q6omgl1dQqW1AawpuUlQSqQ0l7pLX0bz0KTh6PgQteRYTr3i3PZYFtrMwCeJrd10C7
 3GzoUKEZxZQFG+A/4lv+6SigiLegIlwrOLtDxKkI0zEIRWE/wDyPiANPCTJX4gUJPxxgwsoG6
 h1EkFqZbCQEUAVNjwqfKScDB/xd3+k/znhw9R6KAKfrNMZ3NYD7E209teczl/3QIo4q8uJoJm
 rxdannk3u/pbpfTE2Xyq0seswX/U06+GihxfVCWELyfWqIOPJn6cbxLTZnt+MlmW/A+3MKoXa
 hvLw4C6PDxX6MHoM5ZirlwBGzRIFKLSVYsyD63XA4+Baazk6zY4cPiM7VWDbcKfPgaVQhmCUb
 S7wmJ0tgOwybjiuTLjyPftYJuDJ93utP3Ey9buAXQp2Z5c10/BxCOXj6OwvpxNwna1fJb6NHs
 +2QYTUknMZTiK0DGDFpjYRqqN+kYAJ2+EAvOhTt6uuzX/b9p+WtNTrcJfQiUGxdHhSy2mSHYT
 w6n/WwYRf8tksgJR13gKBal21B7xCR40wIuFYpBqo3H4vQPbo6v+TbATM7H1lSAJ3KmL/3EjY
 yxJOreNex+bjL1tfTQxYc5ijCywwGX+1NpmKCxO0+Ph7KsIuutXkjhDO0sYXQTINvz9BtQn/E
 wpykWn7Qv2twgdb8PXy4Wbs4V5ZaaaC6dATbZdtsPX3wiB48omLbXhCnUSXCKBu93xDhnyb3H
 KmGPU3umvQNTuLX2gXHQszO12N8QhsaIh8XA6nQ94Xr/kQu/uczjB9Wi+N96QT9mphYdGCSzf
 Q0QTwQgdSC6gJ1GOaqpXlSfe+lUq8LF3nRtcQ6TM7cmCAxMsn/xb1BttwW0dbiP929OAvUpOZ
 zD2sW9PBp73CgtgVARAW4O0xqTgV78Y6AmzUQdXGOckbJ3WYKYj0mjzRXULBPlosOpLq3H/iX
 uy9pxN+CILvWTqklnbNvA6M4ctF04oupch55fGykXg5l9GtffZ8xFeeeOGvRI/Q2+U8Tgsvqj
 nL5yxObtFHHcXhdKH1n6Mm/eNaNQlSCo8gZfSr9frrDLnMAzcK7EZxxqpvNzeoPrLjcWMhg96
 17RFyGuNAGzU6AMcW7w6b0N58XzJZmUna8rbYKDSG3gVUrY8ozcI+nftXDLmLIa1eXpWtIo2l
 AH/Aa9FAh6ep0nHH/FZiH+qdRI1JzBC16HLFS9QStZeMWP0I/+crcD6pxrwoXWE9aDjzLUsff
 KkqMrx/S77PJzK7GPlyqCMoKEcOOQ8rU0kxU15xf1QfpUmzlIQsHBR4Yygz6Ty92VKVQO8ARA
 e+4XWl1LRoSVNghPqF0ppZRJlZBcMFhGDezZ7vOdY7DftCE4h61K2/OM7fgsnqFDDHL1z9aDI
 QdyzJkbSEyFiFSVoxKpdIVIx4buWuA5P3ufOc841hPtLDNdhfRSixoLmvJ9tFV96wazpUsS3A
 QqKJz2RBuBwZmVftox9yQaKkGSAA91J4eNMC1CDTb7+uxxoh2LrL/6eyWZn5VmolxMMLkxa/V
 J8yL7/l1aXeng5yiMI17dcTnT/5xg7MC7CdIdC5ES00v50ry9UdMm6BXYFt8kU812C663uqvE
 YmrZizhsjteAuur3Wbpw34hLlImGUlv5dlxv1revVRcA5cl/iLkwYC+Rfwc8KeaFlxCsixwOA
 afLJ6ATKXx+TKEmAZypk/pZmVYOLO5lHJF5gm5vIvr7IvhvH/2PulDSN1LmRQWqTbU4QrV7Lt
 nQdDZX/a6UKVBoIQn3C5Vz1LNUNmX1rtl/2UmNJcZt6BzYGllCZriSPzsJOxYXcFv7MmUUZHm
 wuevR90F5WU2v1Bjy+dkOnCzQpTiEkbT4/8QLMDbABBWGhSN0/XDyJywJf4sCUrsjt/5cbOVO
 8t2oe8sLlQYPBj50sLnO/B+HXASSZriqqXyVvwjZlES3IlBmKJaMDOZLifVktwqU40PXUfkqo
 1iHUuCAxFLP1pX2rPwAGsZ4Tpos9LXY3OS7/5CExwGjHFUH80K1jQSvNL4xDUN2gGwK17VQoy
 hWfJ9jJv+59K1USAjss90hXfASgw74RXbzhupnJG/a7lt69W+6BFDwelf+MxcZYLCD4JE3GEs
 GSErXS5o+xmdlbN0tHgtUlostNAMOme7m6VVhFx0AiT+OUT9RvoMTpPZK7pGfypnl3zGf9Hfq
 JMqOhyP/GdLogy35kfvkCPokUUmpLKpKI7SZ0Ktv3H6CSnvwpa9dxPVXjC0TDq9FGyWcNz+N9
 //0g2LGzhq6pWoMykxrcw+UMgUPovRxz/GaueXGItPlDYQ7HIzHXbw9+uxK2HwivnNtfXkohk
 D9SptWkNKWqTWoqMuSzgWgeb1bhK2IoOOa0oXGGkG8A8TDW/HZHazgmV7elnfSmyQdUie/azm
 Bi5XqWQSKSZLraWmQRSQax241AVmGCYgxy3z38DNIMT+vJeynwP/x1dkYaWLufqvlhMNXYfDl
 dWmw7/amJfW5f2D75wq5bXVDDvznGLjm7d0k5MjoboRBg4fZRwm5ZEWJE1suHGbllHW2lx2lA
 PFVBOEtM578ef0iXP5baaRDMdq17fcPGud0i5XdSBbnWX6+AgC5G+PBZAiVSiZUlzWbh3tPsf
 74I9bwySJBUT3zHa85C1woDcnROZCnhJnBoUQ4QjUUgWH7jdnT7OOqIQ+SQWhhQb96nJSxpme
 XVALPcHxyG74SBQgsOxksLLxUTojYBJN//rLAPKjYdTfbJjz+ZG1SegRmyTRfbwD0FVBv1Qvs
 fIVZ05apcFtZ7tLel9AXyf2sYI5zCe4hR5pYXdfwq5WVgXLaZSHKZ3Paoc0aIZ/s33+omtOl2
 /5b3QgNF3JFNsiNPcp2CGHUQcj49Qr0sSFC81fFRo29bdCVz+MBGyhryJEFrzWrXa+zyQwiVI
 Ocs2WstK04AjLSKidDjSKtdG1vLb6uEiS69wLBLTDA6kM3khUdTt6BTrwLynyST+HgFWwitkc
 bJhuyZA/dYsICkosELkyinJrr4tAR2EOrxMsTT0v/ek3YMBczakpMAjC6+ApmTWgxJVJXzfJG
 oXWZxBl/ijzEZrox+xPCclOrUy9H1eLIWFKBCrXrv+/j8jZussVYKEFGdsykUNkMdwi9yEQ0k
 YjBNvhcTDY1dNzyJaxLUjDI0ygaeciIkDqOszH5/aibHELNokDVFq7663UFTYIylv6bO8QaLx
 Ys6D5ITr+FSw4/6ccLZsQ9++XTobESUelLUr/8f3plEtkGdcA2ELDiZcgWmRaPxMYjHxd0I2+
 9U0x2aswmdkpsP+Ci0Xg6KC7LCLV5KXkHsk/Pb7ffm+wgrw9hM6SpetlsTpbh7xpHNFRvkjg/
 ULLSr5zM6rr5oWvgC+ssVCSEJxllXqffo/jTjZ+9xuhyPAGTgW4JSTg5E7INCFMW0pgSVB9Vl
 DfE4VcsgOm5NHACsRL4Nhw5paLLOFSlX9xH045WPjQZoqzwcNaTleaNznTMzpFq6jPsEXFPOs
 OTwQ55dUJP/HUGEforWsDIKBXV5KEykW2vYFkh89mL0DsmGO+/WY84Yep2+/r9Z2Aaeu5r7lY
 5xBprKybieP+A4465QyYxuOZ80I64/7SqhIy3v5heLCqebXL4cao1ThCOjh229yEz4hX/HpBs
 Sy6+XX5hftdwtQUag5iFY8Kz2pqgaMZLh04Z6qVRD3x6xPYc1wZ2cvw5KPdBRiHwoDMeyDxmM
 aWNzsVxLiSyzpLg6jZDFdtYTsR6qr5GTuCmhwcXodEaP/4ClzY4ObVqRS2rG+82HnOauyYfr9
 k1eulHcvVEPOHOl7YSbewSSUM3O6zIMOA+e+kox8jN1npvasTKS3GPUlSjxlVQlI6xxEjpQTz
 nJ7hJ+g1X5tKgS5BgcE4SAwM0jNyoo6wqrDZFBq/zIZGrzmCqovg==

Am Sonntag, dem 26.07.2026 um 01:16 +0200 schrieb Bert Karwatzki:


Now I've run a test with
commit 8bf0cb97edb ("drm/amd/display: Move dml2_destroy to non-FPU compila=
tion unit")
with the following debugging patch:

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/=
drm/amd/display/amdgpu_dm/dc_fpu.c
index 172999cc84e5..5015aea1b988 100644
=2D-- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
@@ -95,7 +95,9 @@ void dc_fpu_begin(const char *function_name, const int l=
ine)
        int depth;
=20
        WARN_ON_ONCE(!in_task());
+       printk(KERN_INFO "%s 0: preempt_count=3D%d %s %d\n", __func__, pre=
empt_count(), function_name, line);
        preempt_disable();
+       printk(KERN_INFO "%s 1: preempt_count=3D%d %s %d\n", __func__, pre=
empt_count(), function_name, line);
        depth =3D this_cpu_inc_return(fpu_recursion_depth);
        if (depth =3D=3D 1) {
                BUG_ON(!kernel_fpu_available());
@@ -127,5 +129,7 @@ void dc_fpu_end(const char *function_name, const int l=
ine)
        }
=20
        TRACE_DCN_FPU(false, function_name, line, depth);
+       printk(KERN_INFO "%s 0: preempt_count=3D%d %s %d\n", __func__, pre=
empt_count(), function_name, line);
        preempt_enable();
+       printk(KERN_INFO "%s 1: preempt_count=3D%d %s %d\n", __func__, pre=
empt_count(), function_name, line);
 }

This gives this log via netconsole in case of a kernel panic, after the "s=
chduling while
atomic" message a preempt_count underflow occurs:

2026-07-26T16:32:29.090401+02:00 T4198;netconsole: network logging started
2026-07-26T16:32:29.091016+02:00 T4198;netconsole-setup: Test log message =
to verify netconsole configuration.
2026-07-26T16:32:32.377992+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
c_state_create_copy 287
2026-07-26T16:32:32.377992+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
c_state_create_copy 287
2026-07-26T16:32:32.378660+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dml=
21_allocate_memory 26
2026-07-26T16:32:32.386022+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dml=
21_allocate_memory 26
2026-07-26T16:32:32.386022+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
ml21_allocate_memory 26
2026-07-26T16:32:32.386022+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
ml21_allocate_memory 26
2026-07-26T16:32:32.386022+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dml=
21_allocate_memory 30
2026-07-26T16:32:32.386022+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dml=
21_allocate_memory 30
2026-07-26T16:32:32.389301+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
ml21_allocate_memory 30
2026-07-26T16:32:32.389301+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
ml21_allocate_memory 30
2026-07-26T16:32:32.389301+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dml=
21_allocate_memory 40
2026-07-26T16:32:32.389301+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dml=
21_allocate_memory 40
2026-07-26T16:32:32.389301+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
ml21_allocate_memory 40
2026-07-26T16:32:32.389301+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
ml21_allocate_memory 40
2026-07-26T16:32:32.390204+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dc_=
state_create_copy 289
2026-07-26T16:32:32.390204+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dc_=
state_create_copy 289
2026-07-26T16:32:32.390204+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
cn401_validate_bandwidth 1696
2026-07-26T16:32:32.390204+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
cn401_validate_bandwidth 1696
2026-07-26T16:32:32.395783+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dcn=
401_validate_bandwidth 1700
2026-07-26T16:32:32.395783+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dcn=
401_validate_bandwidth 1700
2026-07-26T16:32:32.395783+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
c_state_free 387
2026-07-26T16:32:32.395783+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
c_state_free 387
2026-07-26T16:32:32.395783+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dml=
21_destroy 61
2026-07-26T16:32:32.395783+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dml=
21_destroy 61
2026-07-26T16:32:32.395783+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
ml21_destroy 61
2026-07-26T16:32:32.395783+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
ml21_destroy 61
2026-07-26T16:32:32.395836+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dml=
21_destroy 62
2026-07-26T16:32:32.395836+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dml=
21_destroy 62
2026-07-26T16:32:32.395836+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
ml21_destroy 62
2026-07-26T16:32:32.395836+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
ml21_destroy 62
2026-07-26T16:32:32.399013+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dml=
2_destroy 119
2026-07-26T16:32:32.399085+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dml=
2_destroy 119
2026-07-26T16:32:32.399085+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
ml2_destroy 119
2026-07-26T16:32:32.399085+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
ml2_destroy 119
2026-07-26T16:32:32.399085+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dc_=
state_free 393
2026-07-26T16:32:32.399085+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dc_=
state_free 393
2026-07-26T16:32:32.405402+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
c_state_create_copy 287
2026-07-26T16:32:32.405402+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
c_state_create_copy 287
2026-07-26T16:32:32.406122+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dml=
21_allocate_memory 26
2026-07-26T16:32:32.406122+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dml=
21_allocate_memory 26
2026-07-26T16:32:32.408876+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
ml21_allocate_memory 26
2026-07-26T16:32:32.408876+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
ml21_allocate_memory 26
2026-07-26T16:32:32.408876+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dml=
21_allocate_memory 30
2026-07-26T16:32:32.408876+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dml=
21_allocate_memory 30
2026-07-26T16:32:32.416499+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
ml21_allocate_memory 30
2026-07-26T16:32:32.416961+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
ml21_allocate_memory 30
2026-07-26T16:32:32.416961+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dml=
21_allocate_memory 40
2026-07-26T16:32:32.416961+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dml=
21_allocate_memory 40
2026-07-26T16:32:32.431307+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
ml21_allocate_memory 40
2026-07-26T16:32:32.431307+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
ml21_allocate_memory 40
2026-07-26T16:32:32.431984+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dc_=
state_create_copy 289
2026-07-26T16:32:32.431984+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dc_=
state_create_copy 289
2026-07-26T16:32:32.431984+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
cn401_validate_bandwidth 1696
2026-07-26T16:32:32.431984+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
cn401_validate_bandwidth 1696
2026-07-26T16:32:32.431984+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dcn=
401_validate_bandwidth 1700
2026-07-26T16:32:32.431984+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dcn=
401_validate_bandwidth 1700
2026-07-26T16:32:32.431984+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
c_state_create_copy 287
2026-07-26T16:32:32.431984+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
c_state_create_copy 287
2026-07-26T16:32:32.431984+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dml=
21_allocate_memory 26
2026-07-26T16:32:32.431984+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dml=
21_allocate_memory 26
2026-07-26T16:32:32.432058+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
ml21_allocate_memory 26
2026-07-26T16:32:32.432058+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
ml21_allocate_memory 26
2026-07-26T16:32:32.432058+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dml=
21_allocate_memory 30
2026-07-26T16:32:32.432058+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dml=
21_allocate_memory 30
2026-07-26T16:32:32.432058+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
ml21_allocate_memory 30
2026-07-26T16:32:32.432058+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
ml21_allocate_memory 30
2026-07-26T16:32:32.432089+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dml=
21_allocate_memory 40
2026-07-26T16:32:32.432089+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dml=
21_allocate_memory 40
2026-07-26T16:32:32.432089+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
ml21_allocate_memory 40
2026-07-26T16:32:32.432089+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
ml21_allocate_memory 40
2026-07-26T16:32:32.432089+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dc_=
state_create_copy 289
2026-07-26T16:32:32.432089+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dc_=
state_create_copy 289
2026-07-26T16:32:32.432089+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
cn401_validate_bandwidth 1696
2026-07-26T16:32:32.432089+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
cn401_validate_bandwidth 1696
2026-07-26T16:32:32.432089+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dc_=
create_stream_for_sink 180
2026-07-26T16:32:32.432089+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dc_=
create_stream_for_sink 180
2026-07-26T16:32:32.432089+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
c_create_stream_for_sink 180
2026-07-26T16:32:32.432089+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
c_create_stream_for_sink 180
2026-07-26T16:32:32.432579+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dc_=
create_stream_for_sink 185
2026-07-26T16:32:32.432579+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dc_=
create_stream_for_sink 185
2026-07-26T16:32:32.432579+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
c_create_stream_for_sink 185
2026-07-26T16:32:32.432579+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
c_create_stream_for_sink 185
2026-07-26T16:32:32.432579+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dcn=
401_validate_bandwidth 1700
2026-07-26T16:32:32.432579+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dcn=
401_validate_bandwidth 1700
2026-07-26T16:32:32.432579+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
c_state_create_copy 287
2026-07-26T16:32:32.432579+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
c_state_create_copy 287
2026-07-26T16:32:32.432579+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dml=
21_allocate_memory 26
2026-07-26T16:32:32.432579+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dml=
21_allocate_memory 26
2026-07-26T16:32:32.433667+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
ml21_allocate_memory 26
2026-07-26T16:32:32.433667+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
ml21_allocate_memory 26
2026-07-26T16:32:32.433667+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dml=
21_allocate_memory 30
2026-07-26T16:32:32.433667+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dml=
21_allocate_memory 30
2026-07-26T16:32:32.434556+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
ml21_allocate_memory 30
2026-07-26T16:32:32.434556+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
ml21_allocate_memory 30
2026-07-26T16:32:32.434556+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dml=
21_allocate_memory 40
2026-07-26T16:32:32.434556+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dml=
21_allocate_memory 40
2026-07-26T16:32:32.434582+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
ml21_allocate_memory 40
2026-07-26T16:32:32.434582+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
ml21_allocate_memory 40
2026-07-26T16:32:32.434962+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dc_=
state_create_copy 289
2026-07-26T16:32:32.434962+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dc_=
state_create_copy 289
2026-07-26T16:32:32.434962+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
cn401_prepare_mcache_programming 1736
2026-07-26T16:32:32.434962+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
cn401_prepare_mcache_programming 1736
2026-07-26T16:32:32.434962+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dcn=
401_prepare_mcache_programming 1740
2026-07-26T16:32:32.434962+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dcn=
401_prepare_mcache_programming 1740
2026-07-26T16:32:32.434984+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
c_state_free 387
2026-07-26T16:32:32.434984+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
c_state_free 387
2026-07-26T16:32:32.434984+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dml=
21_destroy 61
2026-07-26T16:32:32.434984+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dml=
21_destroy 61
2026-07-26T16:32:32.434984+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
ml21_destroy 61
2026-07-26T16:32:32.434984+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
ml21_destroy 61
2026-07-26T16:32:32.434984+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dml=
21_destroy 62
2026-07-26T16:32:32.435010+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dml=
21_destroy 62
2026-07-26T16:32:32.435010+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
ml21_destroy 62
2026-07-26T16:32:32.435010+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
ml21_destroy 62
2026-07-26T16:32:32.435010+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dml=
2_destroy 119
2026-07-26T16:32:32.435010+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dml=
2_destroy 119
2026-07-26T16:32:32.435010+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
ml2_destroy 119
2026-07-26T16:32:32.435010+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
ml2_destroy 119
2026-07-26T16:32:32.435010+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dc_=
state_free 393
2026-07-26T16:32:32.435010+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dc_=
state_free 393
2026-07-26T16:32:32.435010+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
cn401_prepare_mcache_programming 1736
2026-07-26T16:32:32.435010+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
cn401_prepare_mcache_programming 1736
2026-07-26T16:32:32.435010+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dcn=
401_prepare_mcache_programming 1740
2026-07-26T16:32:32.435010+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dcn=
401_prepare_mcache_programming 1740
2026-07-26T16:32:32.435305+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
c_state_free 387
2026-07-26T16:32:32.435305+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
c_state_free 387
2026-07-26T16:32:32.435305+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dml=
21_destroy 61
2026-07-26T16:32:32.435305+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dml=
21_destroy 61
2026-07-26T16:32:32.463118+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
ml21_destroy 61
2026-07-26T16:32:32.463118+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
ml21_destroy 61
2026-07-26T16:32:32.463118+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dml=
21_destroy 62
2026-07-26T16:32:32.463118+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dml=
21_destroy 62
2026-07-26T16:32:32.463118+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
ml21_destroy 62
2026-07-26T16:32:32.463118+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
ml21_destroy 62
2026-07-26T16:32:32.463118+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dml=
2_destroy 119
2026-07-26T16:32:32.463118+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dml=
2_destroy 119
2026-07-26T16:32:32.463118+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
ml2_destroy 119
2026-07-26T16:32:32.463118+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
ml2_destroy 119
2026-07-26T16:32:32.463118+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dc_=
state_free 393
2026-07-26T16:32:32.463118+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dc_=
state_free 393
2026-07-26T16:32:32.485076+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
c_state_create_copy 287
2026-07-26T16:32:32.485076+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
c_state_create_copy 287
2026-07-26T16:32:32.485076+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dml=
21_allocate_memory 26
2026-07-26T16:32:32.485076+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dml=
21_allocate_memory 26
2026-07-26T16:32:32.488796+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
ml21_allocate_memory 26
2026-07-26T16:32:32.488796+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
ml21_allocate_memory 26
2026-07-26T16:32:32.488796+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dml=
21_allocate_memory 30
2026-07-26T16:32:32.488796+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dml=
21_allocate_memory 30
2026-07-26T16:32:32.489469+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
ml21_allocate_memory 30
2026-07-26T16:32:32.489469+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
ml21_allocate_memory 30
2026-07-26T16:32:32.489469+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dml=
21_allocate_memory 40
2026-07-26T16:32:32.489469+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dml=
21_allocate_memory 40
2026-07-26T16:32:32.489469+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
ml21_allocate_memory 40
2026-07-26T16:32:32.489469+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
ml21_allocate_memory 40
2026-07-26T16:32:32.490008+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dc_=
state_create_copy 289
2026-07-26T16:32:32.490008+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dc_=
state_create_copy 289
2026-07-26T16:32:32.490008+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
cn401_validate_bandwidth 1696
2026-07-26T16:32:32.490008+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
cn401_validate_bandwidth 1696
2026-07-26T16:32:32.490008+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dc_=
create_stream_for_sink 180
2026-07-26T16:32:32.490008+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dc_=
create_stream_for_sink 180
2026-07-26T16:32:32.490408+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
c_create_stream_for_sink 180
2026-07-26T16:32:32.490408+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
c_create_stream_for_sink 180
2026-07-26T16:32:32.490408+02:00 T1596;dc_fpu_end 0: preempt_count=3D1 dc_=
create_stream_for_sink 185
2026-07-26T16:32:32.490408+02:00 T1596;dc_fpu_end 1: preempt_count=3D0 dc_=
create_stream_for_sink 185
2026-07-26T16:32:32.490408+02:00 T1596;dc_fpu_begin 0: preempt_count=3D0 d=
c_create_stream_for_sink 185
2026-07-26T16:32:32.492405+02:00 T1596;dc_fpu_begin 1: preempt_count=3D1 d=
c_create_stream_for_sink 185
2026-07-26T16:32:32.492405+02:00 T1596;BUG: scheduling while atomic: Xorg/=
1596/0x00000003
2026-07-26T16:32:32.492405+02:00 T1596;4 locks held by Xorg/1596:
2026-07-26T16:32:32.492405+02:00 T1596; #0: ffffaa7487f93ab0 (crtc_ww_clas=
s_acquire){+.+.}-{0:0}, at: drm_mode_setcrtc+0x153/0x8e0 [drm]
2026-07-26T16:32:32.492405+02:00 T1596; #1: ffffaa7487f93ad8 (crtc_ww_clas=
s_mutex){+.+.}-{4:4}, at: drm_mode_setcrtc+0x153/0x8e0 [drm]
2026-07-26T16:32:32.492405+02:00 T1596; #2: ffff9b1cd5b65478 (&adev->dm.dc=
_lock){+.+.}-{4:4}, at: amdgpu_dm_atomic_commit_tail+0x120a/0x3460 [amdgpu=
]
2026-07-26T16:32:32.492405+02:00 T1596; #3: ffffffff9afbcc50 (&zone->lock)=
{+.+.}-{3:3}, at: get_page_from_freelist+0x261/0x19f0
2026-07-26T16:32:32.492454+02:00 T1596;Modules linked in: netconsole snd_s=
eq_dummy snd_hrtimer snd_seq cfg80211 nls_ascii nls_cp437 vfat fat joydev
snd_usb_audio snd_usbmidi_lib intel_rapl_msr snd_ump snd_rawmidi intel_rap=
l_common snd_hda_codec_atihdmi snd_seq_device iosf_mbi snd_hda_codec_hdmi =
wmi_bmof
rapl snd_hda_intel pcspkr snd_hda_codec snd_hda_core spd5118 snd_intel_dsp=
cfg regmap_i2c k10temp snd_hwdep snd_pcm snd_timer snd soundcore rfkill ev=
dev ccp
nct6775 nct6775_core hwmon_vid efi_pstore configfs efivarfs autofs4 ext4 m=
bcache jbd2 amdgpu hid_generic usbhid hid drm_client_lib i2c_algo_bit drm_=
buddy
drm_ttm_helper ttm drm_exec drm_suballoc_helper mfd_core drm_panel_backlig=
ht_quirks gpu_sched amdxcp drm_display_helper ahci drm_kms_helper libahci =
xhci_pci drm
libata xhci_hcd nvme scsi_mod cec video nvme_core usbcore igc crc16 scsi_c=
ommon nvme_keyring usb_common nvme_auth hkdf i2c_piix4 gpio_amdpt i2c_smbu=
s wmi
gpio_generic
2026-07-26T16:32:32.492454+02:00 T1596;CPU: 25 UID: 0 PID: 1596 Comm: Xorg=
 Not tainted 7.0.0-rc7-dcfpubad-01910-g3c2692d1b40e #1272 PREEMPT_{RT,(ful=
l)}=20
2026-07-26T16:32:32.492454+02:00 T1596;Hardware name: ASUS System Product =
Name/ROG STRIX B850-F GAMING WIFI, BIOS 1627 02/05/2026
2026-07-26T16:32:32.492454+02:00 T1596;Call Trace:
2026-07-26T16:32:32.492454+02:00 T1596; <TASK>
2026-07-26T16:32:32.492454+02:00 T1596; ? dump_stack_lvl+0x5b/0x80
2026-07-26T16:32:32.492454+02:00 T1596; ? __schedule_bug.cold+0x5a/0x67
2026-07-26T16:32:32.492454+02:00 T1596; ? __schedule+0x1468/0x1ae0
2026-07-26T16:32:32.492454+02:00 T1596; ? rtlock_slowlock_locked+0x281/0x1=
aa0
2026-07-26T16:32:32.492454+02:00 T1596; ? mark_held_locks+0x40/0x70
2026-07-26T16:32:32.492454+02:00 T1596; ? schedule_rtlock+0x15/0x30
2026-07-26T16:32:32.492454+02:00 T1596; ? rtlock_slowlock_locked+0x5b4/0x1=
aa0
2026-07-26T16:32:32.492454+02:00 T1596; ? lock_acquire+0xbf/0x2e0
2026-07-26T16:32:32.492454+02:00 T1596; ? rt_spin_lock+0x85/0x1b0
2026-07-26T16:32:32.492454+02:00 T1596; ? get_page_from_freelist+0x261/0x1=
9f0
2026-07-26T16:32:32.492454+02:00 T1596; ? mark_held_locks+0x40/0x70
2026-07-26T16:32:32.492476+02:00 T1596; ? dc_link_get_highest_encoding_for=
mat+0x61/0xb0 [amdgpu]
2026-07-26T16:32:32.492476+02:00 T1596; ? __alloc_frozen_pages_noprof+0x15=
8/0x370
2026-07-26T16:32:32.493359+02:00 T1596; ? ___kmalloc_large_node+0xd7/0xf0
2026-07-26T16:32:32.494837+02:00 T1596; ? __kmalloc_large_node_noprof+0x1b=
/0x130
2026-07-26T16:32:32.494837+02:00 T1596; ? __kvmalloc_node_noprof+0x4ad/0x7=
30
2026-07-26T16:32:32.494837+02:00 T1596; ? dc_create_plane_state+0x24/0x80 =
[amdgpu]
2026-07-26T16:32:32.494837+02:00 T1596; ? dc_create_plane_state+0x24/0x80 =
[amdgpu]
2026-07-26T16:32:32.494837+02:00 T1596; ? dc_state_create_phantom_plane+0x=
15/0x50 [amdgpu]
2026-07-26T16:32:32.494837+02:00 T1596; ? dml21_handle_phantom_streams_pla=
nes+0x292/0x510 [amdgpu]
2026-07-26T16:32:32.494860+02:00 T1596; ? dml21_mode_check_and_programming=
+0x157/0x7e0 [amdgpu]
2026-07-26T16:32:32.494860+02:00 T1596; ? number+0x47c/0x580
2026-07-26T16:32:32.494860+02:00 T1596; ? desc_read_finalized_seq+0x27/0x8=
0
2026-07-26T16:32:32.494860+02:00 T1596; ? _prb_read_valid+0x203/0x290
2026-07-26T16:32:32.494860+02:00 T1596; ? dcn401_validate_bandwidth+0xb8/0=
x1f0 [amdgpu]
2026-07-26T16:32:32.494860+02:00 T1596; ? update_planes_and_stream_state+0=
xeb5/0x1520 [amdgpu]
2026-07-26T16:32:32.495056+02:00 T1596; ? update_planes_and_stream_prepare=
_v3+0xb3/0x430 [amdgpu]
2026-07-26T16:32:32.495056+02:00 T1596; ? dc_update_planes_and_stream+0x87=
/0x130 [amdgpu]
2026-07-26T16:32:32.495056+02:00 T1596; ? amdgpu_dm_atomic_commit_tail+0x1=
26b/0x3460 [amdgpu]
2026-07-26T16:32:32.495056+02:00 T1596; ? commit_tail+0x9d/0x130 [drm_kms_=
helper]
2026-07-26T16:32:32.495088+02:00 T1596; ? drm_atomic_helper_commit+0x15a/0=
x1a0 [drm_kms_helper]
2026-07-26T16:32:32.495088+02:00 T1596; ? drm_atomic_commit+0xac/0xe0 [drm=
]
2026-07-26T16:32:32.495088+02:00 T1596; ? __drm_universal_plane_init.cold+=
0x17/0x17 [drm]
2026-07-26T16:32:32.495088+02:00 T1596; ? drm_atomic_helper_set_config+0x6=
f/0xb0 [drm_kms_helper]
2026-07-26T16:32:32.495116+02:00 T1596; ? drm_mode_setcrtc+0x466/0x8e0 [dr=
m]
2026-07-26T16:32:32.495116+02:00 T1596; ? lock_acquire+0xbf/0x2e0
2026-07-26T16:32:32.495116+02:00 T1596; ? rt_mutex_slowunlock+0x46/0x420
2026-07-26T16:32:32.495116+02:00 T1596; ? drm_mode_getcrtc+0x190/0x190 [dr=
m]
2026-07-26T16:32:32.495116+02:00 T1596; ? drm_ioctl_kernel+0xa7/0x100 [drm=
]
2026-07-26T16:32:32.495116+02:00 T1596; ? drm_ioctl+0x288/0x510 [drm]
2026-07-26T16:32:32.495116+02:00 T1596; ? drm_mode_getcrtc+0x190/0x190 [dr=
m]
2026-07-26T16:32:32.495141+02:00 T1596; ? amdgpu_drm_ioctl+0x4b/0x80 [amdg=
pu]
2026-07-26T16:32:32.495141+02:00 T1596; ? __x64_sys_ioctl+0x95/0xe0
2026-07-26T16:32:32.495141+02:00 T1596; ? do_syscall_64+0x129/0x6b0
2026-07-26T16:32:32.495141+02:00 T1596; ? rt_mutex_slowunlock+0x3bd/0x420
2026-07-26T16:32:32.495141+02:00 T1596; ? wake_up_q+0x32/0x80
2026-07-26T16:32:32.495141+02:00 T1596; ? futex_wake+0xa7/0x1c0
2026-07-26T16:32:32.495171+02:00 T1596; ? do_futex+0x11a/0x180
2026-07-26T16:32:32.495171+02:00 T1596; ? __x64_sys_futex+0x10d/0x200
2026-07-26T16:32:32.495171+02:00 T1596; ? trace_hardirqs_on_prepare+0xdc/0=
x100
2026-07-26T16:32:32.495171+02:00 T1596; ? lockdep_hardirqs_on_prepare+0xd7=
/0x180
2026-07-26T16:32:32.495171+02:00 T1596; ? trace_hardirqs_on_prepare+0xdc/0=
x100
2026-07-26T16:32:32.495171+02:00 T1596; ? do_syscall_64+0x238/0x6b0
2026-07-26T16:32:32.495171+02:00 T1596; ? trace_hardirqs_on_prepare+0xdc/0=
x100
2026-07-26T16:32:32.495171+02:00 T1596; ? do_syscall_64+0x238/0x6b0
2026-07-26T16:32:32.495189+02:00 T1596; ? trace_hardirqs_on_prepare+0xdc/0=
x100
2026-07-26T16:32:32.495189+02:00 T1596; ? do_syscall_64+0x238/0x6b0
2026-07-26T16:32:32.495189+02:00 T1596; ? trace_hardirqs_on_prepare+0xdc/0=
x100
2026-07-26T16:32:32.495189+02:00 T1596; ? lockdep_hardirqs_on_prepare+0xd7=
/0x180
2026-07-26T16:32:32.495189+02:00 T1596; ? irqentry_exit+0xbd/0x5a0
2026-07-26T16:32:32.495189+02:00 T1596; ? entry_SYSCALL_64_after_hwframe+0=
x55/0x5d
2026-07-26T16:32:32.495189+02:00 T1596; </TASK>
2026-07-26T16:32:32.495189+02:00 T1596;------------[ cut here ]-----------=
-
2026-07-26T16:32:32.495189+02:00 T1596;WARNING: drivers/gpu/drm/amd/amdgpu=
/../display/amdgpu_dm/dc_fpu.c:128 at dc_fpu_end+0x145/0x150 [amdgpu], CPU=
#31:
Xorg/1596
2026-07-26T16:32:32.495189+02:00 T1596;Modules linked in: netconsole snd_s=
eq_dummy snd_hrtimer snd_seq cfg80211 nls_ascii nls_cp437 vfat fat joydev
snd_usb_audio snd_usbmidi_lib intel_rapl_msr snd_ump snd_rawmidi intel_rap=
l_common snd_hda_codec_atihdmi snd_seq_device iosf_mbi snd_hda_codec_hdmi =
wmi_bmof
rapl snd_hda_intel pcspkr snd_hda_codec snd_hda_core spd5118 snd_intel_dsp=
cfg regmap_i2c k10temp snd_hwdep snd_pcm snd_timer snd soundcore rfkill ev=
dev ccp
nct6775 nct6775_core hwmon_vid efi_pstore configfs efivarfs autofs4 ext4 m=
bcache jbd2 amdgpu hid_generic usbhid hid drm_client_lib i2c_algo_bit drm_=
buddy
drm_ttm_helper ttm drm_exec drm_suballoc_helper mfd_core drm_panel_backlig=
ht_quirks gpu_sched amdxcp drm_display_helper ahci drm_kms_helper libahci =
xhci_pci drm
libata xhci_hcd nvme scsi_mod cec video nvme_core usbcore igc crc16 scsi_c=
ommon nvme_keyring usb_common nvme_auth hkdf i2c_piix4 gpio_amdpt i2c_smbu=
s wmi
gpio_generic
2026-07-26T16:32:32.495189+02:00 T1596;CPU: 31 UID: 0 PID: 1596 Comm: Xorg=
 Tainted: G        W           7.0.0-rc7-dcfpubad-01910-g3c2692d1b40e #127=
2
PREEMPT_{RT,(full)}=20
2026-07-26T16:32:32.495189+02:00 T1596;Tainted: [W]=3DWARN
2026-07-26T16:32:32.495238+02:00 T1596;Hardware name: ASUS System Product =
Name/ROG STRIX B850-F GAMING WIFI, BIOS 1627 02/05/2026
2026-07-26T16:32:32.495238+02:00 T1596;RIP: 0010:dc_fpu_end+0x145/0x150 [a=
mdgpu]
2026-07-26T16:32:32.495238+02:00 T1596;Code: c0 0f 85 22 ff ff ff 48 8d 3d=
 07 1f 4b 00 67 48 0f b9 3a e9 11 ff ff ff 44 89 04 24 e8 94 60 12 d9 44 8=
b 04 24 e9
e8 fe ff ff <0f> 0b e9 e1 fe ff ff 0f 1f 40 00 41 56 41 55 41 54 55 53 48 =
83 ec
2026-07-26T16:32:32.495238+02:00 T1596;RSP: 0018:ffffaa7487f93400 EFLAGS: =
00010296
2026-07-26T16:32:32.495238+02:00 T1596;RAX: 0000000000000001 RBX: ffffffff=
c13c39b0 RCX: 0000000000000008
2026-07-26T16:32:32.495238+02:00 T1596;RDX: 0000000000000000 RSI: 00000000=
000006a4 RDI: ffffffffc13c39b0
2026-07-26T16:32:32.495238+02:00 T1596;RBP: 00000000000006a4 R08: 00000000=
ffffffff R09: 0000000000000001
2026-07-26T16:32:32.495238+02:00 T1596;R10: ffff9b1d19c80000 R11: 00000000=
00000002 R12: ffff9b1d066e0000
2026-07-26T16:32:32.495238+02:00 T1596;R13: ffff9b1ce5c00000 R14: 00000000=
00000000 R15: 0000000000000001
2026-07-26T16:32:32.495238+02:00 T1596;FS:  00007f92f4c39b80(0000) GS:ffff=
9b2c62a46000(0000) knlGS:0000000000000000
2026-07-26T16:32:32.496222+02:00 T1596;CS:  0010 DS: 0000 ES: 0000 CR0: 00=
00000080050033
2026-07-26T16:32:32.496222+02:00 T1596;CR2: 00007f2cedfb8990 CR3: 00000001=
27bee000 CR4: 0000000000f50ef0
2026-07-26T16:32:32.496222+02:00 T1596;PKRU: 55555554
2026-07-26T16:32:32.496222+02:00 T1596;Call Trace:
2026-07-26T16:32:32.496222+02:00 T1596; <TASK>
2026-07-26T16:32:32.496234+02:00 T1596; ? dcn401_validate_bandwidth+0xd1/0=
x1f0 [amdgpu]
2026-07-26T16:32:32.496234+02:00 T1596; ? update_planes_and_stream_state+0=
xeb5/0x1520 [amdgpu]
2026-07-26T16:32:32.496234+02:00 T1596; ? update_planes_and_stream_prepare=
_v3+0xb3/0x430 [amdgpu]
2026-07-26T16:32:32.496234+02:00 T1596; ? dc_update_planes_and_stream+0x87=
/0x130 [amdgpu]
2026-07-26T16:32:32.496269+02:00 T1596; ? amdgpu_dm_atomic_commit_tail+0x1=
26b/0x3460 [amdgpu]
2026-07-26T16:32:32.496269+02:00 T1596; ? commit_tail+0x9d/0x130 [drm_kms_=
helper]
2026-07-26T16:32:32.496269+02:00 T1596; ? drm_atomic_helper_commit+0x15a/0=
x1a0 [drm_kms_helper]
2026-07-26T16:32:32.496269+02:00 T1596; ? drm_atomic_commit+0xac/0xe0 [drm=
]
2026-07-26T16:32:32.496269+02:00 T1596; ? __drm_universal_plane_init.cold+=
0x17/0x17 [drm]
2026-07-26T16:32:32.496269+02:00 T1596; ? drm_atomic_helper_set_config+0x6=
f/0xb0 [drm_kms_helper]
2026-07-26T16:32:32.496269+02:00 T1596; ? drm_mode_setcrtc+0x466/0x8e0 [dr=
m]
2026-07-26T16:32:32.496269+02:00 T1596; ? lock_acquire+0xbf/0x2e0
2026-07-26T16:32:32.496269+02:00 T1596; ? rt_mutex_slowunlock+0x46/0x420
2026-07-26T16:32:32.496269+02:00 T1596; ? drm_mode_getcrtc+0x190/0x190 [dr=
m]
2026-07-26T16:32:32.496269+02:00 T1596; ? drm_ioctl_kernel+0xa7/0x100 [drm=
]
2026-07-26T16:32:32.496269+02:00 T1596; ? drm_ioctl+0x288/0x510 [drm]
2026-07-26T16:32:32.496269+02:00 T1596; ? drm_mode_getcrtc+0x190/0x190 [dr=
m]
2026-07-26T16:32:32.496269+02:00 T1596; ? amdgpu_drm_ioctl+0x4b/0x80 [amdg=
pu]
2026-07-26T16:32:32.496269+02:00 T1596; ? __x64_sys_ioctl+0x95/0xe0
2026-07-26T16:32:32.496313+02:00 T1596; ? do_syscall_64+0x129/0x6b0
2026-07-26T16:32:32.496313+02:00 T1596; ? rt_mutex_slowunlock+0x3bd/0x420
2026-07-26T16:32:32.496313+02:00 T1596; ? wake_up_q+0x32/0x80
2026-07-26T16:32:32.496313+02:00 T1596; ? futex_wake+0xa7/0x1c0
2026-07-26T16:32:32.496313+02:00 T1596; ? do_futex+0x11a/0x180
2026-07-26T16:32:32.496313+02:00 T1596; ? __x64_sys_futex+0x10d/0x200
2026-07-26T16:32:32.496313+02:00 T1596; ? trace_hardirqs_on_prepare+0xdc/0=
x100
2026-07-26T16:32:32.496313+02:00 T1596; ? lockdep_hardirqs_on_prepare+0xd7=
/0x180
2026-07-26T16:32:32.496313+02:00 T1596; ? trace_hardirqs_on_prepare+0xdc/0=
x100
2026-07-26T16:32:32.496313+02:00 T1596; ? do_syscall_64+0x238/0x6b0
2026-07-26T16:32:32.496313+02:00 T1596; ? trace_hardirqs_on_prepare+0xdc/0=
x100
2026-07-26T16:32:32.496313+02:00 T1596; ? do_syscall_64+0x238/0x6b0
2026-07-26T16:32:32.496313+02:00 T1596; ? trace_hardirqs_on_prepare+0xdc/0=
x100
2026-07-26T16:32:32.496313+02:00 T1596; ? do_syscall_64+0x238/0x6b0
2026-07-26T16:32:32.496351+02:00 T1596; ? trace_hardirqs_on_prepare+0xdc/0=
x100
2026-07-26T16:32:32.496351+02:00 T1596; ? lockdep_hardirqs_on_prepare+0xd7=
/0x180
2026-07-26T16:32:32.496351+02:00 T1596; ? irqentry_exit+0xbd/0x5a0
2026-07-26T16:32:32.496351+02:00 T1596; ? entry_SYSCALL_64_after_hwframe+0=
x55/0x5d
2026-07-26T16:32:32.496351+02:00 T1596; </TASK>
2026-07-26T16:32:32.496351+02:00 T1596;irq event stamp: 9309205
2026-07-26T16:32:32.496475+02:00 T1596;hardirqs last  enabled at (9309207)=
: [<ffffffff99d6683d>] vprintk_store+0x36d/0x5e0
2026-07-26T16:32:32.496475+02:00 T1596;hardirqs last disabled at (9309208)=
: [<ffffffff99d6685f>] vprintk_store+0x38f/0x5e0
2026-07-26T16:32:32.496475+02:00 T1596;softirqs last  enabled at (9297620)=
: [<ffffffff99ccb56b>] __local_bh_enable_ip+0xfb/0x140
2026-07-26T16:32:32.496475+02:00 T1596;softirqs last disabled at (9297614)=
: [<ffffffff9a4ea8bb>] __alloc_skb+0x24b/0x360
2026-07-26T16:32:32.496475+02:00 T1596;---[ end trace 0000000000000000 ]--=
-
2026-07-26T16:32:32.496475+02:00 T1596;dc_fpu_end 0: preempt_count=3D0 dcn=
401_validate_bandwidth 1700

Here a preempt_count underflow is happening:
2147483647 is actually (-1 & ~PREEMPT_NEED_RESCHED)

static __always_inline int preempt_count(void)
{
 return raw_cpu_read_4(__preempt_count) & ~PREEMPT_NEED_RESCHED;
}


2026-07-26T16:32:32.496475+02:00 C15;dc_fpu_end 1: preempt_count=3D2147483=
647 dcn401_validate_bandwidth 1700
2026-07-26T16:32:32.496475+02:00 T1596;------------[ cut here ]-----------=
-
2026-07-26T16:32:32.496496+02:00 T1596;WARNING: drivers/gpu/drm/amd/amdgpu=
/../display/amdgpu_dm/dc_fpu.c:97 at dc_fpu_begin+0x39/0x40 [amdgpu], CPU#=
15:
Xorg/1596
2026-07-26T16:32:32.496496+02:00 T1596;Modules linked in: netconsole snd_s=
eq_dummy snd_hrtimer snd_seq cfg80211 nls_ascii nls_cp437 vfat fat joydev
snd_usb_audio snd_usbmidi_lib intel_rapl_msr snd_ump snd_rawmidi intel_rap=
l_common snd_hda_codec_atihdmi snd_seq_device iosf_mbi snd_hda_codec_hdmi =
wmi_bmof
rapl snd_hda_intel pcspkr snd_hda_codec snd_hda_core spd5118 snd_intel_dsp=
cfg regmap_i2c k10temp snd_hwdep snd_pcm snd_timer snd soundcore rfkill ev=
dev ccp
nct6775 nct6775_core hwmon_vid efi_pstore configfs efivarfs autofs4 ext4 m=
bcache jbd2 amdgpu hid_generic usbhid hid drm_client_lib i2c_algo_bit drm_=
buddy
drm_ttm_helper ttm drm_exec drm_suballoc_helper mfd_core drm_panel_backlig=
ht_quirks gpu_sched amdxcp drm_display_helper ahci drm_kms_helper libahci =
xhci_pci drm
libata xhci_hcd nvme scsi_mod cec video nvme_core usbcore igc crc16 scsi_c=
ommon nvme_keyring usb_common nvme_auth hkdf i2c_piix4 gpio_amdpt i2c_smbu=
s wmi
gpio_generic
2026-07-26T16:32:32.496496+02:00 T1596;CPU: 15 UID: 0 PID: 1596 Comm: Xorg=
 Tainted: G        W           7.0.0-rc7-dcfpubad-01910-g3c2692d1b40e #127=
2
PREEMPT_{RT,(full)}=20
2026-07-26T16:32:32.496496+02:00 T1596;Tainted: [W]=3DWARN
2026-07-26T16:32:32.496496+02:00 T1596;Hardware name: ASUS System Product =
Name/ROG STRIX B850-F GAMING WIFI, BIOS 1627 02/05/2026
2026-07-26T16:32:32.496496+02:00 T1596;RIP: 0010:dc_fpu_begin+0x39/0x40 [a=
mdgpu]
2026-07-26T16:32:32.496496+02:00 T1596;Code: 65 48 8b 05 d9 f2 63 da 65 8b=
 15 e2 f2 63 da 8b 80 6c 0a 00 00 89 d1 81 e1 00 00 ff 00 25 00 01 00 00 0=
9 c8 0f 84
32 63 3a 00 <0f> 0b e9 2b 63 3a 00 0f 1f 40 d6 55 53 89 f5 48 89 fb 48 83 =
ec 10
2026-07-26T16:32:32.496496+02:00 T1596;RSP: 0018:ffffaa7487f93578 EFLAGS: =
00010206
2026-07-26T16:32:32.496513+02:00 T1596;RAX: 0000000000ff0000 RBX: ffff9b1c=
e5c00000 RCX: 0000000000ff0000
2026-07-26T16:32:32.496513+02:00 T1596;RDX: 000000007fffffff RSI: 00000000=
000006c8 RDI: ffffffffc13c3980
2026-07-26T16:32:32.496513+02:00 T1596;RBP: ffff9b1d19c80000 R08: 00000000=
00005183 R09: ffffffffc13c3980
2026-07-26T16:32:32.496513+02:00 T1596;R10: 00000000000006c8 R11: 00000000=
00000000 R12: ffff9b1d066e0000
2026-07-26T16:32:32.496513+02:00 T1596;R13: 0000000000000001 R14: ffff9b1c=
e5c00000 R15: ffff9b1d043a0000
2026-07-26T16:32:32.496513+02:00 T1596;FS:  00007f92f4c39b80(0000) GS:ffff=
9b2c62646000(0000) knlGS:0000000000000000
2026-07-26T16:32:32.496513+02:00 T1596;CS:  0010 DS: 0000 ES: 0000 CR0: 00=
00000080050033
2026-07-26T16:32:32.496568+02:00 T1596;CR2: 00007ffb1496aff8 CR3: 00000001=
27bee000 CR4: 0000000000f50ef0
2026-07-26T16:32:32.496568+02:00 T1596;PKRU: 55555554
2026-07-26T16:32:32.496568+02:00 T1596;Call Trace:
2026-07-26T16:32:32.496568+02:00 T1596; <TASK>
2026-07-26T16:32:32.496568+02:00 T1596; ? determine_pipe_unlock_order+0x78=
/0xf0 [amdgpu]
2026-07-26T16:32:32.496568+02:00 T1596; ? dcn401_prepare_mcache_programmin=
g+0x2f/0x70 [amdgpu]
2026-07-26T16:32:32.496568+02:00 T1596; ? commit_planes_for_stream+0x157/0=
x1870 [amdgpu]
2026-07-26T16:32:32.496568+02:00 T1596; ? update_planes_and_stream_execute=
_v3+0x3c/0xd0 [amdgpu]
2026-07-26T16:32:32.496568+02:00 T1596; ? dc_update_planes_and_stream+0xb6=
/0x130 [amdgpu]
2026-07-26T16:32:32.496568+02:00 T1596; ? amdgpu_dm_atomic_commit_tail+0x1=
26b/0x3460 [amdgpu]
2026-07-26T16:32:32.496568+02:00 T1596; ? commit_tail+0x9d/0x130 [drm_kms_=
helper]
2026-07-26T16:32:32.496568+02:00 T1596; ? drm_atomic_helper_commit+0x15a/0=
x1a0 [drm_kms_helper]
2026-07-26T16:32:32.496568+02:00 T1596; ? drm_atomic_commit+0xac/0xe0 [drm=
]
2026-07-26T16:32:32.496568+02:00 T1596; ? __drm_universal_plane_init.cold+=
0x17/0x17 [drm]
2026-07-26T16:32:32.496568+02:00 T1596; ? drm_atomic_helper_set_config+0x6=
f/0xb0 [drm_kms_helper]
2026-07-26T16:32:32.496603+02:00 T1596; ? drm_mode_setcrtc+0x466/0x8e0 [dr=
m]
2026-07-26T16:32:32.496603+02:00 T1596; ? lock_acquire+0xbf/0x2e0
2026-07-26T16:32:32.496603+02:00 T1596; ? rt_mutex_slowunlock+0x46/0x420
2026-07-26T16:32:32.496603+02:00 T1596; ? drm_mode_getcrtc+0x190/0x190 [dr=
m]
2026-07-26T16:32:32.496603+02:00 T1596; ? drm_ioctl_kernel+0xa7/0x100 [drm=
]
2026-07-26T16:32:32.496603+02:00 T1596; ? drm_ioctl+0x288/0x510 [drm]
2026-07-26T16:32:32.496603+02:00 T1596; ? drm_mode_getcrtc+0x190/0x190 [dr=
m]
2026-07-26T16:32:39.401337+02:00 T1596; ? amdgpu_drm_ioctl+0x4b/0x80 [amdg=
pu]
2026-07-26T16:32:39.401337+02:00 T1596; ? __x64_sys_ioctl+0x95/0xe0
2026-07-26T16:32:39.401337+02:00 T1596; ? do_syscall_64+0x129/0x6b0
2026-07-26T16:32:39.401337+02:00 T1596; ? rt_mutex_slowunlock+0x3bd/0x420
2026-07-26T16:32:39.401337+02:00 T1596; ? wake_up_q+0x32/0x80
2026-07-26T16:32:39.401337+02:00 T1596; ? futex_wake+0xa7/0x1c0
2026-07-26T16:32:39.401337+02:00 T1596; ? do_futex+0x11a/0x180
2026-07-26T16:32:39.401337+02:00 T1596; ? __x64_sys_futex+0x10d/0x200
2026-07-26T16:32:39.401337+02:00 T1596; ? trace_hardirqs_on_prepare+0xdc/0=
x100
2026-07-26T16:32:39.401337+02:00 T1596; ? lockdep_hardirqs_on_prepare+0xd7=
/0x180
2026-07-26T16:32:39.401337+02:00 T1596; ? trace_hardirqs_on_prepare+0xdc/0=
x100
2026-07-26T16:32:39.401337+02:00 T1596; ? do_syscall_64+0x238/0x6b0
2026-07-26T16:32:39.401337+02:00 T1596; ? trace_hardirqs_on_prepare+0xdc/0=
x100
2026-07-26T16:32:39.401337+02:00 T1596; ? do_syscall_64+0x238/0x6b0
2026-07-26T16:32:39.401337+02:00 T1596; ? trace_hardirqs_on_prepare+0xdc/0=
x100
2026-07-26T16:32:39.401337+02:00 T1596; ? do_syscall_64+0x238/0x6b0
2026-07-26T16:32:39.401337+02:00 T1596; ? trace_hardirqs_on_prepare+0xdc/0=
x100
2026-07-26T16:32:39.401337+02:00 T1596; ? lockdep_hardirqs_on_prepare+0xd7=
/0x180
2026-07-26T16:32:39.401337+02:00 T1596; ? irqentry_exit+0xbd/0x5a0
2026-07-26T16:32:39.401337+02:00 T1596; ? entry_SYSCALL_64_after_hwframe+0=
x55/0x5d
2026-07-26T16:32:39.401337+02:00 T1596; </TASK>
2026-07-26T16:32:39.401337+02:00 T1596;irq event stamp: 9309525
2026-07-26T16:32:39.401337+02:00 T1596;hardirqs last  enabled at (9309527)=
: [<ffffffff99d6683d>] vprintk_store+0x36d/0x5e0
2026-07-26T16:32:39.401337+02:00 T1596;hardirqs last disabled at (9309528)=
: [<ffffffff99d6685f>] vprintk_store+0x38f/0x5e0
2026-07-26T16:32:39.401337+02:00 T1596;softirqs last  enabled at (9297620)=
: [<ffffffff99ccb56b>] __local_bh_enable_ip+0xfb/0x140
2026-07-26T16:32:39.401337+02:00 T1596;softirqs last disabled at (9297614)=
: [<ffffffff9a4ea8bb>] __alloc_skb+0x24b/0x360
2026-07-26T16:32:39.401337+02:00 T1596;---[ end trace 0000000000000000 ]--=
-
2026-07-26T16:32:39.401337+02:00 C15;dc_fpu_begin 0: preempt_count=3D21474=
83647 dcn401_prepare_mcache_programming 1736
2026-07-26T16:32:39.401337+02:00 T1596;dc_fpu_begin 1: preempt_count=3D0 d=
cn401_prepare_mcache_programming 1736
2026-07-26T16:32:39.401337+02:00 T1596;dc_fpu_end 0: preempt_count=3D0 dcn=
401_prepare_mcache_programming 1740
2026-07-26T16:32:39.401337+02:00 C15;dc_fpu_end 1: preempt_count=3D2147483=
647 dcn401_prepare_mcache_programming 1740
2026-07-26T16:32:39.401337+02:00 C15;dc_fpu_begin 0: preempt_count=3D21474=
83647 dc_state_free 387
2026-07-26T16:32:39.401337+02:00 T1596;dc_fpu_begin 1: preempt_count=3D0 d=
c_state_free 387
2026-07-26T16:32:39.401337+02:00 T1596;dc_fpu_end 0: preempt_count=3D0 dml=
21_destroy 61
2026-07-26T16:32:39.401337+02:00 C15;dc_fpu_end 1: preempt_count=3D2147483=
647 dml21_destroy 61
2026-07-26T16:32:39.401337+02:00 T1596;------------[ cut here ]-----------=
-
2026-07-26T16:32:39.401337+02:00 T1596;kernel BUG at mm/vmalloc.c:3412!
2026-07-26T16:32:39.401337+02:00 T1596;Oops: invalid opcode: 0000 [#1] SMP=
 NOPTI
2026-07-26T16:32:39.401337+02:00 T1596;CPU: 15 UID: 0 PID: 1596 Comm: Xorg=
 Tainted: G        W           7.0.0-rc7-dcfpubad-01910-g3c2692d1b40e #127=
2
PREEMPT_{RT,(full)}=20
2026-07-26T16:32:39.401337+02:00 T1596;Tainted: [W]=3DWARN
2026-07-26T16:32:39.401337+02:00 T1596;Hardware name: ASUS System Product =
Name/ROG STRIX B850-F GAMING WIFI, BIOS 1627 02/05/2026
2026-07-26T16:32:39.401337+02:00 T1596;RIP: 0010:vfree_atomic+0x55/0x60
2026-07-26T16:32:39.401337+02:00 T1596;Code: 07 48 89 c1 f0 48 0f b1 3a 75=
 f3 48 85 c9 74 05 c3 cc cc cc cc 48 8b 35 a1 70 c1 00 48 83 c2 08 bf 20 0=
0 00 00 e9
cb 29 d6 ff <0f> 0b 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 41 56 41 54 55 =
53 48
2026-07-26T16:32:39.401337+02:00 T1596;RSP: 0018:ffffaa7487f93600 EFLAGS: =
00010286
2026-07-26T16:32:39.401337+02:00 T1596;RAX: 0000000000ff0000 RBX: ffffaa74=
8748c000 RCX: 0000000000000027
2026-07-26T16:32:39.401337+02:00 T1596;RDX: 0000000000000000 RSI: 00000000=
00000001 RDI: ffffaa748f056000
2026-07-26T16:32:39.401337+02:00 T1596;RBP: ffff9b1d1b400000 R08: 00000000=
00000004 R09: 0000000000000120
2026-07-26T16:32:39.401337+02:00 T1596;R10: 0000000000000200 R11: 00000000=
00000000 R12: ffff9b1d066e0000
2026-07-26T16:32:39.401337+02:00 T1596;R13: ffff9b1ce5c00000 R14: 00000000=
00000001 R15: ffff9b1d043a0000
2026-07-26T16:32:39.401337+02:00 T1596;FS:  00007f92f4c39b80(0000) GS:ffff=
9b2c62646000(0000) knlGS:0000000000000000
2026-07-26T16:32:39.401337+02:00 T1596;CS:  0010 DS: 0000 ES: 0000 CR0: 00=
00000080050033
2026-07-26T16:32:39.401337+02:00 T1596;CR2: 00007ffb1496aff8 CR3: 00000001=
27bee000 CR4: 0000000000f50ef0
2026-07-26T16:32:39.401337+02:00 T1596;PKRU: 55555554
2026-07-26T16:32:39.401337+02:00 T1596;Call Trace:
2026-07-26T16:32:39.401337+02:00 T1596; <TASK>
2026-07-26T16:32:39.401337+02:00 T1596; ? dml21_destroy+0x50/0xa0 [amdgpu]
2026-07-26T16:32:39.401419+02:00 T1596; ? dml2_destroy+0x59/0x60 [amdgpu]
2026-07-26T16:32:39.401419+02:00 T1596; ? dc_state_free+0x31/0x70 [amdgpu]
2026-07-26T16:32:39.401419+02:00 T1596; ? update_planes_and_stream_cleanup=
_v3+0x4f/0x3e0 [amdgpu]
2026-07-26T16:32:39.401419+02:00 T1596; ? dc_update_planes_and_stream+0xc4=
/0x130 [amdgpu]
2026-07-26T16:32:39.401419+02:00 T1596; ? amdgpu_dm_atomic_commit_tail+0x1=
26b/0x3460 [amdgpu]
2026-07-26T16:32:39.401419+02:00 T1596; ? commit_tail+0x9d/0x130 [drm_kms_=
helper]
2026-07-26T16:32:39.401419+02:00 T1596; ? drm_atomic_helper_commit+0x15a/0=
x1a0 [drm_kms_helper]
2026-07-26T16:32:39.401419+02:00 T1596; ? drm_atomic_commit+0xac/0xe0 [drm=
]
2026-07-26T16:32:39.401446+02:00 T1596; ? __drm_universal_plane_init.cold+=
0x17/0x17 [drm]
2026-07-26T16:32:39.401446+02:00 T1596; ? drm_atomic_helper_set_config+0x6=
f/0xb0 [drm_kms_helper]
2026-07-26T16:32:39.401446+02:00 T1596; ? drm_mode_setcrtc+0x466/0x8e0 [dr=
m]
2026-07-26T16:32:39.401446+02:00 T1596; ? lock_acquire+0xbf/0x2e0
2026-07-26T16:32:39.401446+02:00 T1596; ? rt_mutex_slowunlock+0x46/0x420
2026-07-26T16:32:39.401446+02:00 T1596; ? drm_mode_getcrtc+0x190/0x190 [dr=
m]
2026-07-26T16:32:39.401446+02:00 T1596; ? drm_ioctl_kernel+0xa7/0x100 [drm=
]
2026-07-26T16:32:39.401446+02:00 T1596; ? drm_ioctl+0x288/0x510 [drm]
2026-07-26T16:32:39.401467+02:00 T1596; ? drm_mode_getcrtc+0x190/0x190 [dr=
m]
2026-07-26T16:32:39.401467+02:00 T1596; ? amdgpu_drm_ioctl+0x4b/0x80 [amdg=
pu]
2026-07-26T16:32:39.401467+02:00 T1596; ? __x64_sys_ioctl+0x95/0xe0
2026-07-26T16:32:39.401467+02:00 T1596; ? do_syscall_64+0x129/0x6b0
2026-07-26T16:32:39.401467+02:00 T1596; ? rt_mutex_slowunlock+0x3bd/0x420
2026-07-26T16:32:39.401467+02:00 T1596; ? wake_up_q+0x32/0x80
2026-07-26T16:32:39.401467+02:00 T1596; ? futex_wake+0xa7/0x1c0
2026-07-26T16:32:39.401467+02:00 T1596; ? do_futex+0x11a/0x180
2026-07-26T16:32:39.401489+02:00 T1596; ? __x64_sys_futex+0x10d/0x200
2026-07-26T16:32:39.401489+02:00 T1596; ? trace_hardirqs_on_prepare+0xdc/0=
x100
2026-07-26T16:32:39.401489+02:00 T1596; ? lockdep_hardirqs_on_prepare+0xd7=
/0x180
2026-07-26T16:32:39.401489+02:00 T1596; ? trace_hardirqs_on_prepare+0xdc/0=
x100
2026-07-26T16:32:39.401489+02:00 T1596; ? do_syscall_64+0x238/0x6b0
2026-07-26T16:32:39.401489+02:00 T1596; ? trace_hardirqs_on_prepare+0xdc/0=
x100
2026-07-26T16:32:39.401489+02:00 T1596; ? do_syscall_64+0x238/0x6b0
2026-07-26T16:32:39.401489+02:00 T1596; ? trace_hardirqs_on_prepare+0xdc/0=
x100
2026-07-26T16:32:39.401580+02:00 T1596; ? do_syscall_64+0x238/0x6b0
2026-07-26T16:32:39.401580+02:00 T1596; ? trace_hardirqs_on_prepare+0xdc/0=
x100
2026-07-26T16:32:39.401580+02:00 T1596; ? lockdep_hardirqs_on_prepare+0xd7=
/0x180
2026-07-26T16:32:39.401580+02:00 T1596; ? irqentry_exit+0xbd/0x5a0
2026-07-26T16:32:39.401580+02:00 T1596; ? entry_SYSCALL_64_after_hwframe+0=
x55/0x5d
2026-07-26T16:32:39.401580+02:00 T1596; </TASK>
2026-07-26T16:32:39.401580+02:00 T1596;Modules linked in: netconsole snd_s=
eq_dummy snd_hrtimer snd_seq cfg80211 nls_ascii nls_cp437 vfat fat joydev
snd_usb_audio snd_usbmidi_lib intel_rapl_msr snd_ump snd_rawmidi intel_rap=
l_common snd_hda_codec_atihdmi snd_seq_device iosf_mbi snd_hda_codec_hdmi =
wmi_bmof
rapl snd_hda_intel pcspkr snd_hda_codec snd_hda_core spd5118 snd_intel_dsp=
cfg regmap_i2c k10temp snd_hwdep snd_pcm snd_timer snd soundcore rfkill ev=
dev ccp
nct6775 nct6775_core hwmon_vid efi_pstore configfs efivarfs autofs4 ext4 m=
bcache jbd2 amdgpu hid_generic usbhid hid drm_client_lib i2c_algo_bit drm_=
buddy
drm_ttm_helper ttm drm_exec drm_suballoc_helper mfd_core drm_panel_backlig=
ht_quirks gpu_sched amdxcp drm_display_helper ahci drm_kms_helper libahci =
xhci_pci drm
libata xhci_hcd nvme scsi_mod cec video nvme_core usbcore igc crc16 scsi_c=
ommon nvme_keyring usb_common nvme_auth hkdf i2c_piix4 gpio_amdpt i2c_smbu=
s wmi
gpio_generic
2026-07-26T16:32:39.401580+02:00 T1596;---[ end trace 0000000000000000 ]--=
-
2026-07-26T16:32:39.401580+02:00 C10;RIP: 0010:vfree_atomic+0x55/0x60
2026-07-26T16:32:39.401580+02:00 C10;Code: 07 48 89 c1 f0 48 0f b1 3a 75 f=
3 48 85 c9 74 05 c3 cc cc cc cc 48 8b 35 a1 70 c1 00 48 83 c2 08 bf 20 00 =
00 00 e9 cb
29 d6 ff <0f> 0b 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 41 56 41 54 55 53 =
48
2026-07-26T16:32:39.401580+02:00 C10;RSP: 0018:ffffaa7487f93600 EFLAGS: 00=
010286
2026-07-26T16:32:39.401580+02:00 C10;RAX: 0000000000ff0000 RBX: ffffaa7487=
48c000 RCX: 0000000000000027
2026-07-26T16:32:39.401580+02:00 C10;RDX: 0000000000000000 RSI: 0000000000=
000001 RDI: ffffaa748f056000
2026-07-26T16:32:39.401580+02:00 C10;RBP: ffff9b1d1b400000 R08: 0000000000=
000004 R09: 0000000000000120
2026-07-26T16:32:39.401580+02:00 C10;R10: 0000000000000200 R11: 0000000000=
000000 R12: ffff9b1d066e0000
2026-07-26T16:32:39.401580+02:00 C10;R13: ffff9b1ce5c00000 R14: 0000000000=
000001 R15: ffff9b1d043a0000
2026-07-26T16:32:39.401580+02:00 C10;FS:  00007f92f4c39b80(0000) GS:ffff9b=
2c62506000(0000) knlGS:0000000000000000
2026-07-26T16:32:39.401580+02:00 C10;CS:  0010 DS: 0000 ES: 0000 CR0: 0000=
000080050033
2026-07-26T16:32:39.401580+02:00 C10;CR2: 00007f1fb663c478 CR3: 0000000127=
bee000 CR4: 0000000000f50ef0
2026-07-26T16:32:39.401580+02:00 C10;PKRU: 55555554
2026-07-26T16:32:39.401580+02:00 T1596;Kernel panic - not syncing: Fatal e=
xception in interrupt
2026-07-26T16:32:39.401580+02:00 T1596;Kernel Offset: 0x18a00000 from 0xff=
ffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
2026-07-26T16:32:39.401580+02:00 T1596;---[ end Kernel panic - not syncing=
: Fatal exception in interrupt ]---

As the preempt_count_underflow happens in
dcn401_validate_bandwidth() I removed the DC_FP_{START,END} macros:

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resourc=
e.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index cb93bfbe9e9e..7a90098ec118 100644
=2D-- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1693,11 +1693,9 @@ enum dc_status dcn401_validate_bandwidth(struct dc =
*dc,
        }
=20
        if (dc->debug.using_dml2) {
-               DC_FP_START();
                status =3D dml2_validate(dc, context,
                                context->power_source =3D=3D DC_POWER_SOUR=
CE_DC ? context->bw_ctx.dml2_dc_power_source : context->bw_ctx.dml2,
                                validate_mode) ? DC_OK : DC_FAIL_BANDWIDTH=
_VALIDATE;
-               DC_FP_END();
        }
=20
        if (validate_mode =3D=3D DC_VALIDATE_MODE_AND_PROGRAMMING && statu=
s =3D=3D DC_OK && dc_state_is_subvp_in_use(context)) {
@@ -1718,11 +1716,9 @@ enum dc_status dcn401_validate_bandwidth(struct dc =
*dc,
        if (validate_mode =3D=3D DC_VALIDATE_MODE_AND_PROGRAMMING && statu=
s =3D=3D DC_FAIL_HW_CURSOR_SUPPORT) {
                /* attempt to validate again with subvp disabled due to cu=
rsor */
                if (dc->debug.using_dml2) {
-                       DC_FP_START();
                        status =3D dml2_validate(dc, context,
                                        context->power_source =3D=3D DC_PO=
WER_SOURCE_DC ? context->bw_ctx.dml2_dc_power_source : context->bw_ctx.dml=
2,
                                        validate_mode) ? DC_OK : DC_FAIL_B=
ANDWIDTH_VALIDATE;
-                       DC_FP_END();
                }
        }
=20

With this patch I got 24 reboot cycles without any error, (no "scheduling =
while atomic", no panic
an no error from dc_assert_fp_enabled()).


Bert Karwatzki
